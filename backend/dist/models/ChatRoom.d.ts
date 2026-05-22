import mongoose, { Document } from 'mongoose';
export interface IChatRoom extends Document {
    participants: mongoose.Types.ObjectId[];
    lastMessage?: string;
    lastMessageAt?: Date;
    createdAt: Date;
    updatedAt: Date;
}
export declare const ChatRoom: any;
//# sourceMappingURL=ChatRoom.d.ts.map