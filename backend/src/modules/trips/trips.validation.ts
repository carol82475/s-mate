import { z } from 'zod';

export const createTripSchema = z.object({
  body: z.object({
    destination: z
      .string()
      .min(1, 'Destination is required'),

    start_date: z
      .string()
      .min(1, 'Start date is required'),

    end_date: z
      .string()
      .min(1, 'End date is required'),

    budget: z
      .number()
      .min(0)
      .optional(),

    description: z
      .string()
      .optional(),

    travelers: z
      .number()
      .min(1, 'At least one traveler is required'),

    travelers_label: z
      .string()
      .optional(),

    preferences: z
      .array(z.string())
      .optional(),
  }),
});

export const updateTripSchema = z.object({
  body: z.object({
    destination: z.string().optional(),

    start_date: z.string().optional(),

    end_date: z.string().optional(),

    budget: z.number().optional(),

    traveler_count: z.number().optional(),

    preferences: z
      .array(z.string())
      .optional(),

    status: z
      .enum([
        'planning',
        'active',
        'completed',
        'cancelled',
      ])
      .optional(),

    progress: z.number().optional(),
  }),
});

export const updateCheckpointSchema = z.object({
  body: z.object({
    day: z.number().min(1),

    checkpointIndex: z.number().min(0),

    completed: z.boolean(),
  }),
});