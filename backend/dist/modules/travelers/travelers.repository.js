"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TravelersRepository = void 0;
const supabase_1 = require("../../config/supabase");
class TravelersRepository {
    async searchTravelers(query, country, interest, offset, limit) {
        let dbQuery = supabase_1.supabaseAdmin
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
        if (error)
            throw new Error(error.message);
        return { travelers: data || [], count: count || 0 };
    }
    async findById(travelerId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('traveler_profiles')
            .select('*')
            .eq('id', travelerId)
            .single();
        if (error)
            return null;
        return data;
    }
    async findOnlineTravelers(limit) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('traveler_profiles')
            .select('*')
            .eq('is_online', true)
            .limit(limit);
        if (error)
            throw new Error(error.message);
        return data || [];
    }
}
exports.TravelersRepository = TravelersRepository;
//# sourceMappingURL=travelers.repository.js.map