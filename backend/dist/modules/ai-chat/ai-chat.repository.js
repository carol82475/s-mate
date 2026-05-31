"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AiChatRepository = void 0;
const supabase_1 = require("../../config/supabase");
class AiChatRepository {
    async createMessage(messageData) {
        await supabase_1.supabaseAdmin.from('ai_chat_messages').insert(messageData);
    }
    async findMessagesByUserId(userId, limit) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('ai_chat_messages')
            .select('*')
            .eq('user_id', userId)
            .order('created_at', { ascending: false })
            .limit(limit);
        if (error)
            throw new Error(error.message);
        return data || [];
    }
    async deleteMessagesByUserId(userId) {
        const { error } = await supabase_1.supabaseAdmin
            .from('ai_chat_messages')
            .delete()
            .eq('user_id', userId);
        if (error)
            throw new Error(error.message);
    }
}
exports.AiChatRepository = AiChatRepository;
//# sourceMappingURL=ai-chat.repository.js.map