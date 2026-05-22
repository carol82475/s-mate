import mongoose, { Document } from 'mongoose';
export interface IAiMessage {
    role: 'user' | 'assistant';
    content: string;
    timestamp: Date;
}
export interface IAiChatHistory extends Document {
    userId: mongoose.Types.ObjectId;
    messages: IAiMessage[];
    createdAt: Date;
    updatedAt: Date;
}
export declare const AiChatHistory: any;
//# sourceMappingURL=AiChatHistory.d.ts.map