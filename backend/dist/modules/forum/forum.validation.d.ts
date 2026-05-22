import { z } from 'zod';
export declare const createPostSchema: z.ZodObject<{
    body: z.ZodObject<{
        destination: z.ZodString;
        dates: z.ZodOptional<z.ZodString>;
        content: z.ZodString;
        images: z.ZodOptional<z.ZodArray<z.ZodString, "many">>;
    }, "strip", z.ZodTypeAny, {
        destination: string;
        content: string;
        dates?: string | undefined;
        images?: string[] | undefined;
    }, {
        destination: string;
        content: string;
        dates?: string | undefined;
        images?: string[] | undefined;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        destination: string;
        content: string;
        dates?: string | undefined;
        images?: string[] | undefined;
    };
}, {
    body: {
        destination: string;
        content: string;
        dates?: string | undefined;
        images?: string[] | undefined;
    };
}>;
export declare const addCommentSchema: z.ZodObject<{
    body: z.ZodObject<{
        text: z.ZodString;
    }, "strip", z.ZodTypeAny, {
        text: string;
    }, {
        text: string;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        text: string;
    };
}, {
    body: {
        text: string;
    };
}>;
//# sourceMappingURL=forum.validation.d.ts.map