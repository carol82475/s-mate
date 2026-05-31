import { z } from 'zod';
export declare const searchTravelersSchema: z.ZodObject<{
    query: z.ZodObject<{
        query: z.ZodOptional<z.ZodString>;
        country: z.ZodOptional<z.ZodString>;
        interest: z.ZodOptional<z.ZodString>;
        page: z.ZodOptional<z.ZodString>;
        limit: z.ZodOptional<z.ZodString>;
    }, "strip", z.ZodTypeAny, {
        limit?: string | undefined;
        page?: string | undefined;
        country?: string | undefined;
        query?: string | undefined;
        interest?: string | undefined;
    }, {
        limit?: string | undefined;
        page?: string | undefined;
        country?: string | undefined;
        query?: string | undefined;
        interest?: string | undefined;
    }>;
}, "strip", z.ZodTypeAny, {
    query: {
        limit?: string | undefined;
        page?: string | undefined;
        country?: string | undefined;
        query?: string | undefined;
        interest?: string | undefined;
    };
}, {
    query: {
        limit?: string | undefined;
        page?: string | undefined;
        country?: string | undefined;
        query?: string | undefined;
        interest?: string | undefined;
    };
}>;
//# sourceMappingURL=travelers.validation.d.ts.map