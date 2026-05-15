import { supabaseAdmin } from '../../config/supabase';
import {
  Trip,
  TripWithItinerary,
  Checkpoint,
} from './trips.types';

export class TripsRepository {
  async createTrip(tripData: {
    user_id: string;
    destination: string;
    start_date: string;
    end_date: string;
    budget?: number;
    traveler_count: number;
    preferences: string[];
    status: string;
    progress: number;
  }): Promise<Trip> {
    const { data, error } = await supabaseAdmin
      .from('trips')
      .insert(tripData)
      .select()
      .single();

    if (error) {
      throw new Error(error.message);
    }

    return data;
  }

  async findByUserId(
    userId: string,
    status?: string,
    offset = 0,
    limit = 10,
  ): Promise<{ trips: Trip[]; count: number }> {
    let query = supabaseAdmin
      .from('trips')
      .select('*', { count: 'exact' })
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
      .range(offset, offset + limit - 1);

    if (status) {
      query = query.eq('status', status);
    }

    const { data, error, count } = await query;

    if (error) {
      throw new Error(error.message);
    }

    return {
      trips: data || [],
      count: count || 0,
    };
  }

  async findByIdAndUserId(
    tripId: string,
    userId: string,
  ): Promise<TripWithItinerary | null> {
    const { data, error } = await supabaseAdmin
      .from('trips')
      .select(
        `
        *,
        itinerary_days (
          *,
          checkpoints (*)
        )
      `,
      )
      .eq('id', tripId)
      .eq('user_id', userId)
      .single();

    if (error || !data) {
      return null;
    }

    const sortedDays = [...(data.itinerary_days || [])]
      .sort((a, b) => a.day_number - b.day_number)
      .map((day) => {
        const sortedCheckpoints = [...(day.checkpoints || [])].sort(
          (a, b) => a.sort_order - b.sort_order,
        );

        return {
          ...day,
          checkpoints: sortedCheckpoints,
        };
      });

    return {
      ...data,
      itinerary_days: sortedDays,
      itinerary: sortedDays.map((day) => ({
        id: day.id,
        day: day.day_number,
        day_number: day.day_number,
        title: day.title,
        date: day.date,
        checkpoints: day.checkpoints.map((checkpoint: any) => ({
          id: checkpoint.id,
          time: checkpoint.time,
          title: checkpoint.title,
          description: checkpoint.description,
          completed: checkpoint.completed,
          sort_order: checkpoint.sort_order,
        })),
      })),
    };
  }

  async updateTrip(
    tripId: string,
    userId: string,
    updates: Partial<Trip>,
  ): Promise<Trip | null> {
    const { data, error } = await supabaseAdmin
      .from('trips')
      .update(updates)
      .eq('id', tripId)
      .eq('user_id', userId)
      .select()
      .single();

    if (error) {
      return null;
    }

    return data;
  }

  async deleteTrip(
    tripId: string,
    userId: string,
  ): Promise<boolean> {
    const { error } = await supabaseAdmin
      .from('trips')
      .delete()
      .eq('id', tripId)
      .eq('user_id', userId);

    return !error;
  }

  async createItineraryDay(dayData: {
    trip_id: string;
    day_number: number;
    title: string;
    date?: string;
  }) {
    const { data, error } = await supabaseAdmin
      .from('itinerary_days')
      .insert(dayData)
      .select()
      .single();

    if (error) {
      throw new Error(error.message);
    }

    return data;
  }

  async createCheckpoints(
    checkpoints: Array<{
      itinerary_day_id: string;
      time: string;
      title: string;
      description: string;
      completed: boolean;
      sort_order: number;
    }>,
  ) {
    if (checkpoints.length === 0) {
      return;
    }

    const { error } = await supabaseAdmin
      .from('checkpoints')
      .insert(checkpoints);

    if (error) {
      throw new Error(error.message);
    }
  }

  async findCheckpointsByTripId(
    tripId: string,
  ): Promise<Checkpoint[]> {
    const { data, error } = await supabaseAdmin
      .from('checkpoints')
      .select(
        `
        *,
        itinerary_days!inner (
          trip_id
        )
      `,
      )
      .eq('itinerary_days.trip_id', tripId);

    if (error) {
      throw new Error(error.message);
    }

    return data || [];
  }

  async updateCheckpoint(
    checkpointId: string,
    completed: boolean,
  ): Promise<void> {
    const { error } = await supabaseAdmin
      .from('checkpoints')
      .update({ completed })
      .eq('id', checkpointId);

    if (error) {
      throw new Error(error.message);
    }
  }

  async findCheckpointsByDayIds(
    dayIds: string[],
  ): Promise<Checkpoint[]> {
    if (dayIds.length === 0) {
      return [];
    }

    const { data, error } = await supabaseAdmin
      .from('checkpoints')
      .select('*')
      .in('itinerary_day_id', dayIds);

    if (error) {
      throw new Error(error.message);
    }

    return data || [];
  }
}