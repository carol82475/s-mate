import { z } from 'zod';

export const searchTravelersSchema = z.object({
  query: z.object({
    query: z.string().optional(),
    country: z.string().optional(),
    interest: z.string().optional(),
    page: z.string().optional(),
    limit: z.string().optional(),
  }),
});
