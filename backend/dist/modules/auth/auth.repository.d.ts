export declare class AuthRepository {
    createUser(email: string, password: string, fullName: string): Promise<import("@supabase/auth-js").User>;
    signIn(email: string, password: string): Promise<{
        user: import("@supabase/auth-js").User;
        session: import("@supabase/auth-js").Session;
        weakPassword?: import("@supabase/auth-js").WeakPassword;
    }>;
    updateOnlineStatus(userId: string, isOnline: boolean): Promise<void>;
    getProfile(userId: string): Promise<any>;
    resetPassword(email: string, redirectTo: string): Promise<void>;
}
//# sourceMappingURL=auth.repository.d.ts.map