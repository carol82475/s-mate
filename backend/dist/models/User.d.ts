import { Document } from 'mongoose';
export interface IUser extends Document {
    name: string;
    email: string;
    password: string;
    avatar?: string;
    country?: string;
    bio?: string;
    interests: string[];
    language: string;
    notificationsEnabled: boolean;
    privacySettings: {
        showOnlineStatus: boolean;
        showLocation: boolean;
    };
    stats: {
        tripsCompleted: number;
        placesVisited: number;
        photosShared: number;
    };
    isOnline: boolean;
    lastSeen: Date;
    googleId?: string;
    createdAt: Date;
    updatedAt: Date;
}
export declare const User: any;
//# sourceMappingURL=User.d.ts.map