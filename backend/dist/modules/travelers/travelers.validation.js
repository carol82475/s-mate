"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.searchTravelersSchema = void 0;
const zod_1 = require("zod");
exports.searchTravelersSchema = zod_1.z.object({
    query: zod_1.z.object({
        query: zod_1.z.string().optional(),
        country: zod_1.z.string().optional(),
        interest: zod_1.z.string().optional(),
        page: zod_1.z.string().optional(),
        limit: zod_1.z.string().optional(),
    }),
});
//# sourceMappingURL=travelers.validation.js.map