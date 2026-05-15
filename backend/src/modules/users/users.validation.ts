import { z } from 'zod';

export const updateProfileSchema = z.object({
  body: z.object({
    name: z.string().min(2).optional(),
    avatar: z.string().optional(),
    country: z.string().optional(),
    bio: z.string().optional(),
    interests: z.array(z.string()).optional(),
  }),
});

export const updateSettingsSchema = z.object({
  body: z.object({
    language: z.string().optional(),
    notificationsEnabled: z.boolean().optional(),
    privacySettings: z
      .object({
        showOnlineStatus: z.boolean().optional(),
        showLocation: z.boolean().optional(),
      })
      .optional(),
  }),
});

export const changePasswordSchema = z.object({
  body: z.object({
    currentPassword: z.string().min(1, 'Current password is required'),
    newPassword: z.string().min(6, 'New password must be at least 6 characters'),
  }),
});
