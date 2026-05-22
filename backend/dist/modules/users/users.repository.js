"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UsersRepository = void 0;
const supabase_1 = require("../../config/supabase");
class UsersRepository {
    async getProfile(userId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('profiles')
            .select('*')
            .eq('id', userId)
            .single();
        if (error)
            throw error;
        return data;
    }
    async updateProfile(userId, updates) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('profiles')
            .update(updates)
            .eq('id', userId)
            .select()
            .single();
        if (error)
            throw error;
        return data;
    }
    async updateTravelerProfile(userId, updates) {
        const { error } = await supabase_1.supabaseAdmin
            .from('traveler_profiles')
            .update(updates)
            .eq('user_id', userId);
        if (error)
            throw error;
    }
    async changePassword(userId, newPassword) {
        const { error } = await supabase_1.supabaseAdmin.auth.admin.updateUserById(userId, {
            password: newPassword,
        });
        if (error)
            throw error;
    }
    async getTripHistory(userId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('trips')
            .select('id, destination, start_date, end_date, status, progress, created_at')
            .eq('user_id', userId)
            .order('created_at', { ascending: false });
        if (error)
            throw error;
        return data;
    }
}
exports.UsersRepository = UsersRepository;
//# sourceMappingURL=users.repository.js.map