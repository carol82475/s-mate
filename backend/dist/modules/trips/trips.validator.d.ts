import { z } from 'zod';
export declare const createTripSchema: z.ZodObject<{
    body: z.ZodObject<{
        destination: z.ZodString;
        startDate: z.ZodString;
        endDate: z.ZodString;
        budget: z.ZodNumber;
        travelerCount: z.ZodNumber;
        preferences: z.ZodOptional<z.ZodArray<z.ZodString, "many">>;
    }, "strip", z.ZodTypeAny, {
        destination: string;
        budget: number;
        startDate: string;
        endDate: string;
        travelerCount: number;
        preferences?: string[] | undefined;
    }, {
        destination: string;
        budget: number;
        startDate: string;
        endDate: string;
        travelerCount: number;
        preferences?: string[] | undefined;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        destination: string;
        budget: number;
        startDate: string;
        endDate: string;
        travelerCount: number;
        preferences?: string[] | undefined;
    };
}, {
    body: {
        destination: string;
        budget: number;
        startDate: string;
        endDate: string;
        travelerCount: number;
        preferences?: string[] | undefined;
    };
}>;
export declare const updateTripSchema: z.ZodObject<{
    body: z.ZodObject<{
        destination: z.ZodOptional<z.ZodString>;
        startDate: z.ZodOptional<z.ZodString>;
        endDate: z.ZodOptional<z.ZodString>;
        budget: z.ZodOptional<z.ZodNumber>;
        travelerCount: z.ZodOptional<z.ZodNumber>;
        preferences: z.ZodOptional<z.ZodArray<z.ZodString, "many">>;
        status: z.ZodOptional<z.ZodEnum<["planning", "active", "completed", "cancelled"]>>;
    }, "strip", z.ZodTypeAny, {
        status?: "planning" | "active" | "completed" | "cancelled" | undefined;
        destination?: string | undefined;
        budget?: number | undefined;
        preferences?: string[] | undefined;
        startDate?: string | undefined;
        endDate?: string | undefined;
        travelerCount?: number | undefined;
    }, {
        status?: "planning" | "active" | "completed" | "cancelled" | undefined;
        destination?: string | undefined;
        budget?: number | undefined;
        preferences?: string[] | undefined;
        startDate?: string | undefined;
        endDate?: string | undefined;
        travelerCount?: number | undefined;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        status?: "planning" | "active" | "completed" | "cancelled" | undefined;
        destination?: string | undefined;
        budget?: number | undefined;
        preferences?: string[] | undefined;
        startDate?: string | undefined;
        endDate?: string | undefined;
        travelerCount?: number | undefined;
    };
}, {
    body: {
        status?: "planning" | "active" | "completed" | "cancelled" | undefined;
        destination?: string | undefined;
        budget?: number | undefined;
        preferences?: string[] | undefined;
        startDate?: string | undefined;
        endDate?: string | undefined;
        travelerCount?: number | undefined;
    };
}>;
//# sourceMappingURL=trips.validator.d.ts.map