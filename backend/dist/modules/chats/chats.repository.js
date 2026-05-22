"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ChatsRepository = void 0;
const supabase_1 = require("../../config/supabase");
class ChatsRepository {
    async findRoomsByUserId(userId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('chat_room_members')
            .select(`
        room_id,
        chat_rooms (
          id,
          last_message,
          last_message_at,
          created_at
        )
      `)
            .eq('user_id', userId)
            .order('chat_rooms(last_message_at)', { ascending: false });
        if (error)
            throw new Error(error.message);
        return data.map((item) => item.chat_rooms);
    }
    async findRoomById(roomId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('chat_rooms')
            .select('*')
            .eq('id', roomId)
            .single();
        if (error)
            return null;
        return data;
    }
    async findMembership(roomId, userId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('chat_room_members')
            .select('*')
            .eq('room_id', roomId)
            .eq('user_id', userId)
            .single();
        if (error)
            return null;
        return data;
    }
    async findRoomsByMember(userId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('chat_room_members')
            .select('room_id')
            .eq('user_id', userId);
        if (error)
            throw new Error(error.message);
        return data.map((item) => item.room_id);
    }
    async findOtherMember(roomId, userId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('chat_room_members')
            .select('*')
            .eq('room_id', roomId)
            .neq('user_id', userId)
            .single();
        if (error)
            return null;
        return data;
    }
    async createRoom() {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('chat_rooms')
            .insert({})
            .select()
            .single();
        if (error)
            throw new Error(error.message);
        return data;
    }
    async addMembers(roomId, userIds) {
        const members = userIds.map((userId) => ({ room_id: roomId, user_id: userId }));
        const { error } = await supabase_1.supabaseAdmin.from('chat_room_members').insert(members);
        if (error)
            throw new Error(error.message);
    }
    async findMessages(roomId, offset, limit) {
        const { data, error, count } = await supabase_1.supabaseAdmin
            .from('chat_messages')
            .select('*', { count: 'exact' })
            .eq('room_id', roomId)
            .order('created_at', { ascending: false })
            .range(offset, offset + limit - 1);
        if (error)
            throw new Error(error.message);
        return { messages: data || [], count: count || 0 };
    }
    async createMessage(messageData) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('chat_messages')
            .insert(messageData)
            .select()
            .single();
        if (error)
            throw new Error(error.message);
        return data;
    }
    async updateRoomLastMessage(roomId, text, timestamp) {
        const { error } = await supabase_1.supabaseAdmin
            .from('chat_rooms')
            .update({
            last_message: text,
            last_message_at: timestamp,
        })
            .eq('id', roomId);
        if (error)
            throw new Error(error.message);
    }
    async markMessagesAsRead(roomId, userId) {
        const { error } = await supabase_1.supabaseAdmin
            .from('chat_messages')
            .update({
            read_by: supabase_1.supabaseAdmin.rpc('array_append', {
                arr: 'read_by',
                elem: userId,
            }),
        })
            .eq('room_id', roomId)
            .neq('sender_id', userId);
        if (error)
            throw new Error(error.message);
    }
}
exports.ChatsRepository = ChatsRepository;
//# sourceMappingURL=chats.repository.js.map