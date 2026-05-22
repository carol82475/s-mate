"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.changePasswordSchema = exports.updateSettingsSchema = exports.updateProfileSchema = void 0;
const zod_1 = require("zod");
exports.updateProfileSchema = zod_1.z.object({
    body: zod_1.z.object({
        name: zod_1.z.string().min(2).optional(),
        avatar: zod_1.z.string().optional(),
        country: zod_1.z.string().optional(),
        bio: zod_1.z.string().optional(),
        interests: zod_1.z.array(zod_1.z.string()).optional(),
    }),
});
exports.updateSettingsSchema = zod_1.z.object({
    body: zod_1.z.object({
        language: zod_1.z.string().optional(),
        notificationsEnabled: zod_1.z.boolean().optional(),
        privacySettings: zod_1.z
            .object({
            showOnlineStatus: zod_1.z.boolean().optional(),
            showLocation: zod_1.z.boolean().optional(),
        })
            .optional(),
    }),
});
exports.changePasswordSchema = zod_1.z.object({
    body: zod_1.z.object({
        currentPassword: zod_1.z.string().min(1, 'Current password is required'),
        newPassword: zod_1.z.string().min(6, 'New password must be at least 6 characters'),
    }),
});
//# sourceMappingURL=users.validation.js.map