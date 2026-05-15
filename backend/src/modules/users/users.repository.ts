import { supabaseAdmin } from '../../config/supabase';

export class UsersRepository {
  async getProfile(userId: string) {
    const { data, error } = await supabaseAdmin
      .from('profiles')
      .select('*')
      .eq('id', userId)
      .single();

    if (error) throw error;
    return data;
  }

  async updateProfile(userId: string, updates: any) {
    const { data, error } = await supabaseAdmin
      .from('profiles')
      .update(updates)
      .eq('id', userId)
      .select()
      .single();

    if (error) throw error;
    return data;
  }

  async updateTravelerProfile(userId: string, updates: any) {
    const { error } = await supabaseAdmin
      .from('traveler_profiles')
      .update(updates)
      .eq('user_id', userId);

    if (error) throw error;
  }

  async changePassword(userId: string, newPassword: string) {
    const { error } = await supabaseAdmin.auth.admin.updateUserById(userId, {
      password: newPassword,
    });

    if (error) throw error;
  }

  async getTripHistory(userId: string) {
    const { data, error } = await supabaseAdmin
      .from('trips')
      .select('id, destination, start_date, end_date, status, progress, created_at')
      .eq('user_id', userId)
      .order('created_at', { ascending: false });

    if (error) throw error;
    return data;
  }
}
