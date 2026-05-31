export interface AiChatMessage {
    id: string;
    user_id: string;
    role: 'user' | 'assistant';
    content: string;
    created_at: string;
}
export interface SendMessageDTO {
    message: string;
}
//# sourceMappingURL=ai-chat.types.d.ts.map