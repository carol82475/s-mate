import { z } from 'zod';

export const createChatRoomSchema = z.object({
  body: z.object({
    otherUserId: z.string().uuid('Invalid user ID'),
  }),
});

export const sendMessageSchema = z.object({
  body: z.object({
    text: z.string().min(1, 'Message text is required'),
    type: z.enum(['text', 'image', 'location']).optional(),
  }),
});
