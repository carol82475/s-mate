export declare class ChatsService {
    private repository;
    constructor();
    getChatRooms(userId: string): Promise<import("./chats.types").ChatRoom[]>;
    getChatRoom(roomId: string, userId: string): Promise<import("./chats.types").ChatRoom>;
    getOrCreateChatRoom(userId: string, otherUserId: string): Promise<import("./chats.types").ChatRoom | null>;
    getChatMessages(roomId: string, userId: string, page?: number, limit?: number): Promise<{
        messages: import("./chats.types").ChatMessage[];
        pagination: {
            page: number;
            limit: number;
            total: number;
            totalPages: number;
        };
    }>;
    sendMessage(roomId: string, userId: string, text: string, type?: string): Promise<import("./chats.types").ChatMessage>;
    markMessagesAsRead(roomId: string, userId: string): Promise<{
        message: string;
    }>;
}
//# sourceMappingURL=chats.service.d.ts.map