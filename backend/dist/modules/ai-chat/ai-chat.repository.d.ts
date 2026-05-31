import { AiChatMessage } from './ai-chat.types';
export declare class AiChatRepository {
    createMessage(messageData: {
        user_id: string;
        role: 'user' | 'assistant';
        content: string;
    }): Promise<void>;
    findMessagesByUserId(userId: string, limit: number): Promise<AiChatMessage[]>;
    deleteMessagesByUserId(userId: string): Promise<void>;
}
//# sourceMappingURL=ai-chat.repository.d.ts.map