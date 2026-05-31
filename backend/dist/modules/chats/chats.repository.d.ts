import { ChatRoom, ChatMessage, ChatRoomMember } from './chats.types';
export declare class ChatsRepository {
    findRoomsByUserId(userId: string): Promise<ChatRoom[]>;
    findRoomById(roomId: string): Promise<ChatRoom | null>;
    findMembership(roomId: string, userId: string): Promise<ChatRoomMember | null>;
    findRoomsByMember(userId: string): Promise<string[]>;
    findOtherMember(roomId: string, userId: string): Promise<ChatRoomMember | null>;
    createRoom(): Promise<ChatRoom>;
    addMembers(roomId: string, userIds: string[]): Promise<void>;
    findMessages(roomId: string, offset: number, limit: number): Promise<{
        messages: ChatMessage[];
        count: number;
    }>;
    createMessage(messageData: {
        room_id: string;
        sender_id: string;
        text: string;
        type: string;
    }): Promise<ChatMessage>;
    updateRoomLastMessage(roomId: string, text: string, timestamp: string): Promise<void>;
    markMessagesAsRead(roomId: string, userId: string): Promise<void>;
}
//# sourceMappingURL=chats.repository.d.ts.map