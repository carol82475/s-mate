"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.updateTripSchema = exports.createTripSchema = void 0;
const zod_1 = require("zod");
exports.createTripSchema = zod_1.z.object({
    body: zod_1.z.object({
        destination: zod_1.z.string().min(1, 'Destination is required'),
        startDate: zod_1.z.string().min(1, 'Start date is required'),
        endDate: zod_1.z.string().min(1, 'End date is required'),
        budget: zod_1.z.number().min(0, 'Budget must be positive'),
        travelerCount: zod_1.z.number().int().min(1, 'At least 1 traveler required'),
        preferences: zod_1.z.array(zod_1.z.string()).optional(),
    }),
});
exports.updateTripSchema = zod_1.z.object({
    body: zod_1.z.object({
        destination: zod_1.z.string().optional(),
        startDate: zod_1.z.string().optional(),
        endDate: zod_1.z.string().optional(),
        budget: zod_1.z.number().min(0).optional(),
        travelerCount: zod_1.z.number().int().min(1).optional(),
        preferences: zod_1.z.array(zod_1.z.string()).optional(),
        status: zod_1.z.enum(['planning', 'active', 'completed', 'cancelled']).optional(),
    }),
});
//# sourceMappingURL=trips.validator.js.map