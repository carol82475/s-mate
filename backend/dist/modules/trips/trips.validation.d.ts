import { z } from 'zod';
export declare const createTripSchema: z.ZodObject<{
    body: z.ZodObject<{
        destination: z.ZodString;
        start_date: z.ZodString;
        end_date: z.ZodString;
        budget: z.ZodOptional<z.ZodNumber>;
        description: z.ZodOptional<z.ZodString>;
        travelers: z.ZodNumber;
        travelers_label: z.ZodOptional<z.ZodString>;
        preferences: z.ZodOptional<z.ZodArray<z.ZodString, "many">>;
    }, "strip", z.ZodTypeAny, {
        destination: string;
        start_date: string;
        end_date: string;
        travelers: number;
        budget?: number | undefined;
        preferences?: string[] | undefined;
        description?: string | undefined;
        travelers_label?: string | undefined;
    }, {
        destination: string;
        start_date: string;
        end_date: string;
        travelers: number;
        budget?: number | undefined;
        preferences?: string[] | undefined;
        description?: string | undefined;
        travelers_label?: string | undefined;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        destination: string;
        start_date: string;
        end_date: string;
        travelers: number;
        budget?: number | undefined;
        preferences?: string[] | undefined;
        description?: string | undefined;
        travelers_label?: string | undefined;
    };
}, {
    body: {
        destination: string;
        start_date: string;
        end_date: string;
        travelers: number;
        budget?: number | undefined;
        preferences?: string[] | undefined;
        description?: string | undefined;
        travelers_label?: string | undefined;
    };
}>;
export declare const updateTripSchema: z.ZodObject<{
    body: z.ZodObject<{
        destination: z.ZodOptional<z.ZodString>;
        start_date: z.ZodOptional<z.ZodString>;
        end_date: z.ZodOptional<z.ZodString>;
        budget: z.ZodOptional<z.ZodNumber>;
        traveler_count: z.ZodOptional<z.ZodNumber>;
        preferences: z.ZodOptional<z.ZodArray<z.ZodString, "many">>;
        status: z.ZodOptional<z.ZodEnum<["planning", "active", "completed", "cancelled"]>>;
        progress: z.ZodOptional<z.ZodNumber>;
    }, "strip", z.ZodTypeAny, {
        status?: "planning" | "active" | "completed" | "cancelled" | undefined;
        destination?: string | undefined;
        start_date?: string | undefined;
        end_date?: string | undefined;
        progress?: number | undefined;
        budget?: number | undefined;
        traveler_count?: number | undefined;
        preferences?: string[] | undefined;
    }, {
        status?: "planning" | "active" | "completed" | "cancelled" | undefined;
        destination?: string | undefined;
        start_date?: string | undefined;
        end_date?: string | undefined;
        progress?: number | undefined;
        budget?: number | undefined;
        traveler_count?: number | undefined;
        preferences?: string[] | undefined;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        status?: "planning" | "active" | "completed" | "cancelled" | undefined;
        destination?: string | undefined;
        start_date?: string | undefined;
        end_date?: string | undefined;
        progress?: number | undefined;
        budget?: number | undefined;
        traveler_count?: number | undefined;
        preferences?: string[] | undefined;
    };
}, {
    body: {
        status?: "planning" | "active" | "completed" | "cancelled" | undefined;
        destination?: string | undefined;
        start_date?: string | undefined;
        end_date?: string | undefined;
        progress?: number | undefined;
        budget?: number | undefined;
        traveler_count?: number | undefined;
        preferences?: string[] | undefined;
    };
}>;
export declare const updateCheckpointSchema: z.ZodObject<{
    body: z.ZodObject<{
        day: z.ZodNumber;
        checkpointIndex: z.ZodNumber;
        completed: z.ZodBoolean;
    }, "strip", z.ZodTypeAny, {
        completed: boolean;
        day: number;
        checkpointIndex: number;
    }, {
        completed: boolean;
        day: number;
        checkpointIndex: number;
    }>;
}, "strip", z.ZodTypeAny, {
    body: {
        completed: boolean;
        day: number;
        checkpointIndex: number;
    };
}, {
    body: {
        completed: boolean;
        day: number;
        checkpointIndex: number;
    };
}>;
//# sourceMappingURL=trips.validation.d.ts.map