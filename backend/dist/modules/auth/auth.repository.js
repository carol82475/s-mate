"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthRepository = void 0;
const supabase_1 = require("../../config/supabase");
class AuthRepository {
    async createUser(email, password, fullName) {
        const { data, error } = await supabase_1.supabaseAdmin.auth.admin.createUser({
            email,
            password,
            email_confirm: true,
            user_metadata: {
                full_name: fullName,
            },
        });
        if (error)
            throw error;
        return data.user;
    }
    async signIn(email, password) {
        const { data, error } = await supabase_1.supabase.auth.signInWithPassword({
            email,
            password,
        });
        if (error)
            throw error;
        return data;
    }
    async updateOnlineStatus(userId, isOnline) {
        const { error } = await supabase_1.supabaseAdmin
            .from('profiles')
            .update({
            is_online: isOnline,
            last_seen: new Date().toISOString(),
        })
            .eq('id', userId);
        if (error)
            throw error;
    }
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
    async resetPassword(email, redirectTo) {
        const { error } = await supabase_1.supabase.auth.resetPasswordForEmail(email, {
            redirectTo,
        });
        if (error)
            throw error;
    }
}
exports.AuthRepository = AuthRepository;
//# sourceMappingURL=auth.repository.js.map