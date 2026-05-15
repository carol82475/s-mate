import { supabaseAdmin } from '../../config/supabase';
import { ChatRoom, ChatMessage, ChatRoomMember } from './chats.types';

export class ChatsRepository {
  async findRoomsByUserId(userId: string): Promise<ChatRoom[]> {
    const { data, error } = await supabaseAdmin
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

    if (error) throw new Error(error.message);

    return data.map((item: any) => item.chat_rooms);
  }

  async findRoomById(roomId: string): Promise<ChatRoom | null> {
    const { data, error } = await supabaseAdmin
      .from('chat_rooms')
      .select('*')
      .eq('id', roomId)
      .single();

    if (error) return null;
    return data;
  }

  async findMembership(roomId: string, userId: string): Promise<ChatRoomMember | null> {
    const { data, error } = await supabaseAdmin
      .from('chat_room_members')
      .select('*')
      .eq('room_id', roomId)
      .eq('user_id', userId)
      .single();

    if (error) return null;
    return data;
  }

  async findRoomsByMember(userId: string): Promise<string[]> {
    const { data, error } = await supabaseAdmin
      .from('chat_room_members')
      .select('room_id')
      .eq('user_id', userId);

    if (error) throw new Error(error.message);
    return data.map((item) => item.room_id);
  }

  async findOtherMember(roomId: string, userId: string): Promise<ChatRoomMember | null> {
    const { data, error } = await supabaseAdmin
      .from('chat_room_members')
      .select('*')
      .eq('room_id', roomId)
      .neq('user_id', userId)
      .single();

    if (error) return null;
    return data;
  }

  async createRoom(): Promise<ChatRoom> {
    const { data, error } = await supabaseAdmin
      .from('chat_rooms')
      .insert({})
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  }

  async addMembers(roomId: string, userIds: string[]): Promise<void> {
    const members = userIds.map((userId) => ({ room_id: roomId, user_id: userId }));

    const { error } = await supabaseAdmin.from('chat_room_members').insert(members);

    if (error) throw new Error(error.message);
  }

  async findMessages(
    roomId: string,
    offset: number,
    limit: number
  ): Promise<{ messages: ChatMessage[]; count: number }> {
    const { data, error, count } = await supabaseAdmin
      .from('chat_messages')
      .select('*', { count: 'exact' })
      .eq('room_id', roomId)
      .order('created_at', { ascending: false })
      .range(offset, offset + limit - 1);

    if (error) throw new Error(error.message);

    return { messages: data || [], count: count || 0 };
  }

  async createMessage(messageData: {
    room_id: string;
    sender_id: string;
    text: string;
    type: string;
  }): Promise<ChatMessage> {
    const { data, error } = await supabaseAdmin
      .from('chat_messages')
      .insert(messageData)
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  }

  async updateRoomLastMessage(roomId: string, text: string, timestamp: string): Promise<void> {
    const { error } = await supabaseAdmin
      .from('chat_rooms')
      .update({
        last_message: text,
        last_message_at: timestamp,
      })
      .eq('id', roomId);

    if (error) throw new Error(error.message);
  }

  async markMessagesAsRead(roomId: string, userId: string): Promise<void> {
    const { error } = await supabaseAdmin
      .from('chat_messages')
      .update({
        read_by: supabaseAdmin.rpc('array_append', {
          arr: 'read_by',
          elem: userId,
        }) as any,
      })
      .eq('room_id', roomId)
      .neq('sender_id', userId);

    if (error) throw new Error(error.message);
  }
}
