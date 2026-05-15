import { z } from "zod";

export const createAlbumSchema = z.object({
  body: z.object({
    name: z.string().min(1, "Album name is required"),
    description: z.string().optional(),
    tripId: z.string().uuid().optional(),
  }),
});

export const addPhotoSchema = z.object({
  body: z.object({
    url: z.string().url("Invalid image URL"),
    caption: z.string().optional(),
  }),
});

export const addTripPhotoSchema = z.object({
  body: z.object({
    image_url: z.string().url("Invalid image URL"),
    caption: z.string().optional(),
    location: z.string().optional(),
    metadata: z.record(z.unknown()).optional(),
  }),
});
