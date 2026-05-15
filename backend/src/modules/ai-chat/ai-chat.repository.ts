import { supabaseAdmin } from '../../config/supabase';
import { AiChatMessage } from './ai-chat.types';

export class AiChatRepository {
  async createMessage(messageData: {
    user_id: string;
    role: 'user' | 'assistant';
    content: string;
  }): Promise<void> {
    await supabaseAdmin.from('ai_chat_messages').insert(messageData);
  }

  async findMessagesByUserId(userId: string, limit: number): Promise<AiChatMessage[]> {
    const { data, error } = await supabaseAdmin
      .from('ai_chat_messages')
      .select('*')
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
      .limit(limit);

    if (error) throw new Error(error.message);
    return data || [];
  }

  async deleteMessagesByUserId(userId: string): Promise<void> {
    const { error } = await supabaseAdmin
      .from('ai_chat_messages')
      .delete()
      .eq('user_id', userId);

    if (error) throw new Error(error.message);
  }
}
