"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TripsRepository = void 0;
const supabase_1 = require("../../config/supabase");
class TripsRepository {
    async createTrip(tripData) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('trips')
            .insert(tripData)
            .select()
            .single();
        if (error) {
            throw new Error(error.message);
        }
        return data;
    }
    async findByUserId(userId, status, offset = 0, limit = 10) {
        let query = supabase_1.supabaseAdmin
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
    async findByIdAndUserId(tripId, userId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('trips')
            .select(`
        *,
        itinerary_days (
          *,
          checkpoints (*)
        )
      `)
            .eq('id', tripId)
            .eq('user_id', userId)
            .single();
        if (error || !data) {
            return null;
        }
        const sortedDays = [...(data.itinerary_days || [])]
            .sort((a, b) => a.day_number - b.day_number)
            .map((day) => {
            const sortedCheckpoints = [...(day.checkpoints || [])].sort((a, b) => a.sort_order - b.sort_order);
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
                checkpoints: day.checkpoints.map((checkpoint) => ({
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
    async updateTrip(tripId, userId, updates) {
        const { data, error } = await supabase_1.supabaseAdmin
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
    async deleteTrip(tripId, userId) {
        const { error } = await supabase_1.supabaseAdmin
            .from('trips')
            .delete()
            .eq('id', tripId)
            .eq('user_id', userId);
        return !error;
    }
    async createItineraryDay(dayData) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('itinerary_days')
            .insert(dayData)
            .select()
            .single();
        if (error) {
            throw new Error(error.message);
        }
        return data;
    }
    async createCheckpoints(checkpoints) {
        if (checkpoints.length === 0) {
            return;
        }
        const { error } = await supabase_1.supabaseAdmin
            .from('checkpoints')
            .insert(checkpoints);
        if (error) {
            throw new Error(error.message);
        }
    }
    async findCheckpointsByTripId(tripId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('checkpoints')
            .select(`
        *,
        itinerary_days!inner (
          trip_id
        )
      `)
            .eq('itinerary_days.trip_id', tripId);
        if (error) {
            throw new Error(error.message);
        }
        return data || [];
    }
    async updateCheckpoint(checkpointId, completed) {
        const { error } = await supabase_1.supabaseAdmin
            .from('checkpoints')
            .update({ completed })
            .eq('id', checkpointId);
        if (error) {
            throw new Error(error.message);
        }
    }
    async findCheckpointsByDayIds(dayIds) {
        if (dayIds.length === 0) {
            return [];
        }
        const { data, error } = await supabase_1.supabaseAdmin
            .from('checkpoints')
            .select('*')
            .in('itinerary_day_id', dayIds);
        if (error) {
            throw new Error(error.message);
        }
        return data || [];
    }
}
exports.TripsRepository = TripsRepository;
//# sourceMappingURL=trips.repository.js.map