import { ProfileResponse, UpdateProfileDto, UpdateSettingsDto } from './users.types';
export declare class UsersService {
    private repository;
    constructor();
    getProfile(userId: string): Promise<ProfileResponse>;
    updateProfile(userId: string, dto: UpdateProfileDto): Promise<{
        id: any;
        name: any;
        avatar: any;
        country: any;
        bio: any;
        interests: any;
    }>;
    updateSettings(userId: string, dto: UpdateSettingsDto): Promise<{
        language: any;
        notificationsEnabled: any;
        privacySettings: {
            showOnlineStatus: any;
            showLocation: any;
        };
    }>;
    changePassword(userId: string, _currentPassword: string, newPassword: string): Promise<{
        message: string;
    }>;
    getTripHistory(userId: string): Promise<{
        id: any;
        destination: any;
        start_date: any;
        end_date: any;
        status: any;
        progress: any;
        created_at: any;
    }[]>;
    getStats(userId: string): Promise<{
        tripsCompleted: any;
        placesVisited: any;
        photosShared: any;
    }>;
}
//# sourceMappingURL=users.service.d.ts.map