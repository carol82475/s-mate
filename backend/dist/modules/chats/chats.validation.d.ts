import { z } from 'zod';
export declare const createChatRoomSchema: z.ZodObject<{
    body: z.ZodObject<{
        otherUserId: z.ZodString;
    }, "strip", z.ZodTypeAny, {
        otherUserId: string;
    }, {
        otherUserId: string;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        otherUserId: string;
    };
}, {
    body: {
        otherUserId: string;
    };
}>;
export declare const sendMessageSchema: z.ZodObject<{
    body: z.ZodObject<{
        text: z.ZodString;
        type: z.ZodOptional<z.ZodEnum<["text", "image", "location"]>>;
    }, "strip", z.ZodTypeAny, {
        text: string;
        type?: "text" | "image" | "location" | undefined;
    }, {
        text: string;
        type?: "text" | "image" | "location" | undefined;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        text: string;
        type?: "text" | "image" | "location" | undefined;
    };
}, {
    body: {
        text: string;
        type?: "text" | "image" | "location" | undefined;
    };
}>;
//# sourceMappingURL=chats.validation.d.ts.map