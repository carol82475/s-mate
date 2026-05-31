import { z } from 'zod';
export declare const registerSchema: z.ZodObject<{
    body: z.ZodObject<{
        name: z.ZodString;
        email: z.ZodString;
        password: z.ZodString;
    }, "strip", z.ZodTypeAny, {
        name: string;
        email: string;
        password: string;
    }, {
        name: string;
        email: string;
        password: string;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        name: string;
        email: string;
        password: string;
    };
}, {
    body: {
        name: string;
        email: string;
        password: string;
    };
}>;
export declare const loginSchema: z.ZodObject<{
    body: z.ZodObject<{
        email: z.ZodString;
        password: z.ZodString;
    }, "strip", z.ZodTypeAny, {
        email: string;
        password: string;
    }, {
        email: string;
        password: string;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        email: string;
        password: string;
    };
}, {
    body: {
        email: string;
        password: string;
    };
}>;
export declare const forgotPasswordSchema: z.ZodObject<{
    body: z.ZodObject<{
        email: z.ZodString;
    }, "strip", z.ZodTypeAny, {
        email: string;
    }, {
        email: string;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        email: string;
    };
}, {
    body: {
        email: string;
    };
}>;
//# sourceMappingURL=auth.validator.d.ts.map