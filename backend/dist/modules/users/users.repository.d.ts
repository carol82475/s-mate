export declare class UsersRepository {
    getProfile(userId: string): Promise<any>;
    updateProfile(userId: string, updates: any): Promise<any>;
    updateTravelerProfile(userId: string, updates: any): Promise<void>;
    changePassword(userId: string, newPassword: string): Promise<void>;
    getTripHistory(userId: string): Promise<{
        id: any;
        destination: any;
        start_date: any;
        end_date: any;
        status: any;
        progress: any;
        created_at: any;
    }[]>;
}
//# sourceMappingURL=users.repository.d.ts.map