import { z } from 'zod';

export const createPostSchema = z.object({
  body: z.object({
    destination: z.string().min(1, 'Destination is required'),
    dates: z.string().optional(),
    content: z.string().min(1, 'Content is required'),
    images: z.array(z.string().url()).optional(),
  }),
});

export const addCommentSchema = z.object({
  body: z.object({
    text: z.string().min(1, 'Comment text is required'),
  }),
});