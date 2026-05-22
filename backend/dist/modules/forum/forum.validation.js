"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.addCommentSchema = exports.createPostSchema = void 0;
const zod_1 = require("zod");
exports.createPostSchema = zod_1.z.object({
    body: zod_1.z.object({
        destination: zod_1.z.string().min(1, 'Destination is required'),
        dates: zod_1.z.string().optional(),
        content: zod_1.z.string().min(1, 'Content is required'),
        images: zod_1.z.array(zod_1.z.string().url()).optional(),
    }),
});
exports.addCommentSchema = zod_1.z.object({
    body: zod_1.z.object({
        text: zod_1.z.string().min(1, 'Comment text is required'),
    }),
});
//# sourceMappingURL=forum.validation.js.map