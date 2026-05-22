import mongoose, { Document } from 'mongoose';
export interface IChatMessage extends Document {
    roomId: mongoose.Types.ObjectId;
    senderId: mongoose.Types.ObjectId;
    text: string;
    type: 'text' | 'image' | 'voice' | 'video';
    isRead: boolean;
    createdAt: Date;
    updatedAt: Date;
}
export declare const ChatMessage: any;
//# sourceMappingURL=ChatMessage.d.ts.map