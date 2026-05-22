"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sendMessageSchema = exports.createChatRoomSchema = void 0;
const zod_1 = require("zod");
exports.createChatRoomSchema = zod_1.z.object({
    body: zod_1.z.object({
        otherUserId: zod_1.z.string().uuid('Invalid user ID'),
    }),
});
exports.sendMessageSchema = zod_1.z.object({
    body: zod_1.z.object({
        text: zod_1.z.string().min(1, 'Message text is required'),
        type: zod_1.z.enum(['text', 'image', 'location']).optional(),
    }),
});
//# sourceMappingURL=chats.validation.js.map