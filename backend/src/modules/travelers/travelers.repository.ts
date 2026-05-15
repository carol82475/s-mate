import { supabaseAdmin } from '../../config/supabase';
import { TravelerProfile } from './travelers.types';

export class TravelersRepository {
  async searchTravelers(
    query: string | undefined,
    country: string | undefined,
    interest: string | undefined,
    offset: number,
    limit: number
  ): Promise<{ travelers: TravelerProfile[]; count: number }> {
    let dbQuery = supabaseAdmin
      .from('traveler_profiles')
      .select('*', { count: 'exact' })
      .order('is_online', { ascending: false })
      .order('last_seen', { ascending: false })
      .range(offset, offset + limit - 1);

    if (query) {
      dbQuery = dbQuery.ilike('display_name', `%${query}%`);
    }

    if (country) {
      dbQuery = dbQuery.ilike('country', `%${country}%`);
    }

    if (interest) {
      dbQuery = dbQuery.contains('interests', [interest]);
    }

    const { data, error, count } = await dbQuery;

    if (error) throw new Error(error.message);

    return { travelers: data || [], count: count || 0 };
  }

  async findById(travelerId: string): Promise<TravelerProfile | null> {
    const { data, error } = await supabaseAdmin
      .from('traveler_profiles')
      .select('*')
      .eq('id', travelerId)
      .single();

    if (error) return null;
    return data;
  }

  async findOnlineTravelers(limit: number): Promise<TravelerProfile[]> {
    const { data, error } = await supabaseAdmin
      .from('traveler_profiles')
      .select('*')
      .eq('is_online', true)
      .limit(limit);

    if (error) throw new Error(error.message);
    return data || [];
  }
}
