export declare const config: {
    env: string;
    port: number;
    apiVersion: string;
    supabase: {
        url: string;
        anonKey: string;
        serviceRoleKey: string;
    };
    cors: {
        origin: string[];
    };
    rateLimit: {
        windowMs: number;
        max: number;
    };
    ai: {
        openaiKey: string | undefined;
        geminiKey: string | undefined;
    };
    socket: {
        corsOrigin: string;
    };
    logging: {
        level: string;
    };
};
//# sourceMappingURL=env.d.ts.map