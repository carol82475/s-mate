import { z } from "zod";
export declare const createAlbumSchema: z.ZodObject<{
    body: z.ZodObject<{
        name: z.ZodString;
        description: z.ZodOptional<z.ZodString>;
        tripId: z.ZodOptional<z.ZodString>;
    }, "strip", z.ZodTypeAny, {
        name: string;
        description?: string | undefined;
        tripId?: string | undefined;
    }, {
        name: string;
        description?: string | undefined;
        tripId?: string | undefined;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        name: string;
        description?: string | undefined;
        tripId?: string | undefined;
    };
}, {
    body: {
        name: string;
        description?: string | undefined;
        tripId?: string | undefined;
    };
}>;
export declare const addPhotoSchema: z.ZodObject<{
    body: z.ZodObject<{
        url: z.ZodString;
        caption: z.ZodOptional<z.ZodString>;
    }, "strip", z.ZodTypeAny, {
        url: string;
        caption?: string | undefined;
    }, {
        url: string;
        caption?: string | undefined;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        url: string;
        caption?: string | undefined;
    };
}, {
    body: {
        url: string;
        caption?: string | undefined;
    };
}>;
export declare const addTripPhotoSchema: z.ZodObject<{
    body: z.ZodObject<{
        image_url: z.ZodString;
        caption: z.ZodOptional<z.ZodString>;
        location: z.ZodOptional<z.ZodString>;
        metadata: z.ZodOptional<z.ZodRecord<z.ZodString, z.ZodUnknown>>;
    }, "strip", z.ZodTypeAny, {
        image_url: string;
        location?: string | undefined;
        caption?: string | undefined;
        metadata?: Record<string, unknown> | undefined;
    }, {
        image_url: string;
        location?: string | undefined;
        caption?: string | undefined;
        metadata?: Record<string, unknown> | undefined;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        image_url: string;
        location?: string | undefined;
        caption?: string | undefined;
        metadata?: Record<string, unknown> | undefined;
    };
}, {
    body: {
        image_url: string;
        location?: string | undefined;
        caption?: string | undefined;
        metadata?: Record<string, unknown> | undefined;
    };
}>;
//# sourceMappingURL=albums.validation.d.ts.map