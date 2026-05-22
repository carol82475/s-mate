export declare class AiChatService {
    private repository;
    constructor();
    sendMessage(userId: string, message: string): Promise<{
        message: string;
        timestamp: string;
    }>;
    getChatHistory(userId: string, limit?: number): Promise<{
        messages: import("./ai-chat.types").AiChatMessage[];
    }>;
    clearChatHistory(userId: string): Promise<{
        message: string;
    }>;
    private generateMockResponse;
}
//# sourceMappingURL=ai-chat.service.d.ts.map