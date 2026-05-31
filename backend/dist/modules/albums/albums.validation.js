"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.addTripPhotoSchema = exports.addPhotoSchema = exports.createAlbumSchema = void 0;
const zod_1 = require("zod");
exports.createAlbumSchema = zod_1.z.object({
    body: zod_1.z.object({
        name: zod_1.z.string().min(1, "Album name is required"),
        description: zod_1.z.string().optional(),
        tripId: zod_1.z.string().uuid().optional(),
    }),
});
exports.addPhotoSchema = zod_1.z.object({
    body: zod_1.z.object({
        url: zod_1.z.string().url("Invalid image URL"),
        caption: zod_1.z.string().optional(),
    }),
});
exports.addTripPhotoSchema = zod_1.z.object({
    body: zod_1.z.object({
        image_url: zod_1.z.string().url("Invalid image URL"),
        caption: zod_1.z.string().optional(),
        location: zod_1.z.string().optional(),
        metadata: zod_1.z.record(zod_1.z.unknown()).optional(),
    }),
});
//# sourceMappingURL=albums.validation.js.map