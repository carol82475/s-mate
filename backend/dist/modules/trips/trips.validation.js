"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.updateCheckpointSchema = exports.updateTripSchema = exports.createTripSchema = void 0;
const zod_1 = require("zod");
exports.createTripSchema = zod_1.z.object({
    body: zod_1.z.object({
        destination: zod_1.z
            .string()
            .min(1, 'Destination is required'),
        start_date: zod_1.z
            .string()
            .min(1, 'Start date is required'),
        end_date: zod_1.z
            .string()
            .min(1, 'End date is required'),
        budget: zod_1.z
            .number()
            .min(0)
            .optional(),
        description: zod_1.z
            .string()
            .optional(),
        travelers: zod_1.z
            .number()
            .min(1, 'At least one traveler is required'),
        travelers_label: zod_1.z
            .string()
            .optional(),
        preferences: zod_1.z
            .array(zod_1.z.string())
            .optional(),
    }),
});
exports.updateTripSchema = zod_1.z.object({
    body: zod_1.z.object({
        destination: zod_1.z.string().optional(),
        start_date: zod_1.z.string().optional(),
        end_date: zod_1.z.string().optional(),
        budget: zod_1.z.number().optional(),
        traveler_count: zod_1.z.number().optional(),
        preferences: zod_1.z
            .array(zod_1.z.string())
            .optional(),
        status: zod_1.z
            .enum([
            'planning',
            'active',
            'completed',
            'cancelled',
        ])
            .optional(),
        progress: zod_1.z.number().optional(),
    }),
});
exports.updateCheckpointSchema = zod_1.z.object({
    body: zod_1.z.object({
        day: zod_1.z.number().min(1),
        checkpointIndex: zod_1.z.number().min(0),
        completed: zod_1.z.boolean(),
    }),
});
//# sourceMappingURL=trips.validation.js.map