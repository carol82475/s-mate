"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sendMessageSchema = void 0;
const zod_1 = require("zod");
exports.sendMessageSchema = zod_1.z.object({
    body: zod_1.z.object({
        message: zod_1.z.string().min(1, 'Message is required'),
    }),
});
//# sourceMappingURL=ai-chat.validation.js.map