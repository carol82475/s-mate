import { z } from 'zod';

export const createTripSchema = z.object({
  body: z.object({
    destination: z.string().min(1, 'Destination is required'),
    startDate: z.string().min(1, 'Start date is required'),
    endDate: z.string().min(1, 'End date is required'),
    budget: z.number().min(0, 'Budget must be positive'),
    travelerCount: z.number().int().min(1, 'At least 1 traveler required'),
    preferences: z.array(z.string()).optional(),
  }),
});

export const updateTripSchema = z.object({
  body: z.object({
    destination: z.string().optional(),
    startDate: z.string().optional(),
    endDate: z.string().optional(),
    budget: z.number().min(0).optional(),
    travelerCount: z.number().int().min(1).optional(),
    preferences: z.array(z.string()).optional(),
    status: z.enum(['planning', 'active', 'completed', 'cancelled']).optional(),
  }),
});
