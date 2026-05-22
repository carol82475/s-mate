import { z } from 'zod';
export declare const updateProfileSchema: z.ZodObject<{
    body: z.ZodObject<{
        name: z.ZodOptional<z.ZodString>;
        avatar: z.ZodOptional<z.ZodString>;
        country: z.ZodOptional<z.ZodString>;
        bio: z.ZodOptional<z.ZodString>;
        interests: z.ZodOptional<z.ZodArray<z.ZodString, "many">>;
    }, "strip", z.ZodTypeAny, {
        name?: string | undefined;
        avatar?: string | undefined;
        country?: string | undefined;
        bio?: string | undefined;
        interests?: string[] | undefined;
    }, {
        name?: string | undefined;
        avatar?: string | undefined;
        country?: string | undefined;
        bio?: string | undefined;
        interests?: string[] | undefined;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        name?: string | undefined;
        avatar?: string | undefined;
        country?: string | undefined;
        bio?: string | undefined;
        interests?: string[] | undefined;
    };
}, {
    body: {
        name?: string | undefined;
        avatar?: string | undefined;
        country?: string | undefined;
        bio?: string | undefined;
        interests?: string[] | undefined;
    };
}>;
export declare const updateSettingsSchema: z.ZodObject<{
    body: z.ZodObject<{
        language: z.ZodOptional<z.ZodString>;
        notificationsEnabled: z.ZodOptional<z.ZodBoolean>;
        privacySettings: z.ZodOptional<z.ZodObject<{
            showOnlineStatus: z.ZodOptional<z.ZodBoolean>;
            showLocation: z.ZodOptional<z.ZodBoolean>;
        }, "strip", z.ZodTypeAny, {
            showOnlineStatus?: boolean | undefined;
            showLocation?: boolean | undefined;
        }, {
            showOnlineStatus?: boolean | undefined;
            showLocation?: boolean | undefined;
        }>>;
    }, "strip", z.ZodTypeAny, {
        language?: string | undefined;
        notificationsEnabled?: boolean | undefined;
        privacySettings?: {
            showOnlineStatus?: boolean | undefined;
            showLocation?: boolean | undefined;
        } | undefined;
    }, {
        language?: string | undefined;
        notificationsEnabled?: boolean | undefined;
        privacySettings?: {
            showOnlineStatus?: boolean | undefined;
            showLocation?: boolean | undefined;
        } | undefined;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        language?: string | undefined;
        notificationsEnabled?: boolean | undefined;
        privacySettings?: {
            showOnlineStatus?: boolean | undefined;
            showLocation?: boolean | undefined;
        } | undefined;
    };
}, {
    body: {
        language?: string | undefined;
        notificationsEnabled?: boolean | undefined;
        privacySettings?: {
            showOnlineStatus?: boolean | undefined;
            showLocation?: boolean | undefined;
        } | undefined;
    };
}>;
export declare const changePasswordSchema: z.ZodObject<{
    body: z.ZodObject<{
        currentPassword: z.ZodString;
        newPassword: z.ZodString;
    }, "strip", z.ZodTypeAny, {
        currentPassword: string;
        newPassword: string;
    }, {
        currentPassword: string;
        newPassword: string;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        currentPassword: string;
        newPassword: string;
    };
}, {
    body: {
        currentPassword: string;
        newPassword: string;
    };
}>;
//# sourceMappingURL=users.validation.d.ts.map