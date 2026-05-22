"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UsersService = void 0;
const users_repository_1 = require("./users.repository");
class UsersService {
    constructor() {
        this.repository = new users_repository_1.UsersRepository();
    }
    async getProfile(userId) {
        const profile = await this.repository.getProfile(userId);
        return {
            id: profile.id,
            name: profile.full_name,
            avatar: profile.avatar_url,
            country: profile.country,
            bio: profile.bio,
            interests: profile.interests || [],
            language: profile.language,
            notificationsEnabled: profile.notifications_enabled,
            privacySettings: {
                showOnlineStatus: profile.privacy_show_online,
                showLocation: profile.privacy_show_location,
            },
            stats: {
                tripsCompleted: profile.stats_trips_completed,
                placesVisited: profile.stats_places_visited,
                photosShared: profile.stats_photos_shared,
            },
            isOnline: profile.is_online,
            lastSeen: profile.last_seen,
        };
    }
    async updateProfile(userId, dto) {
        const updates = {};
        if (dto.name)
            updates.full_name = dto.name;
        if (dto.avatar)
            updates.avatar_url = dto.avatar;
        if (dto.country)
            updates.country = dto.country;
        if (dto.bio)
            updates.bio = dto.bio;
        if (dto.interests)
            updates.interests = dto.interests;
        const profile = await this.repository.updateProfile(userId, updates);
        // Sync with traveler_profiles
        await this.repository.updateTravelerProfile(userId, {
            display_name: dto.name || profile.full_name,
            avatar_url: dto.avatar || profile.avatar_url,
            country: dto.country || profile.country,
            bio: dto.bio || profile.bio,
            interests: dto.interests || profile.interests,
        });
        return {
            id: profile.id,
            name: profile.full_name,
            avatar: profile.avatar_url,
            country: profile.country,
            bio: profile.bio,
            interests: profile.interests,
        };
    }
    async updateSettings(userId, dto) {
        const updates = {};
        if (dto.language !== undefined) {
            updates.language = dto.language;
        }
        if (dto.notificationsEnabled !== undefined) {
            updates.notifications_enabled = dto.notificationsEnabled;
        }
        if (dto.privacySettings) {
            if (dto.privacySettings.showOnlineStatus !== undefined) {
                updates.privacy_show_online = dto.privacySettings.showOnlineStatus;
            }
            if (dto.privacySettings.showLocation !== undefined) {
                updates.privacy_show_location = dto.privacySettings.showLocation;
            }
        }
        const profile = await this.repository.updateProfile(userId, updates);
        return {
            language: profile.language,
            notificationsEnabled: profile.notifications_enabled,
            privacySettings: {
                showOnlineStatus: profile.privacy_show_online,
                showLocation: profile.privacy_show_location,
            },
        };
    }
    async changePassword(userId, _currentPassword, newPassword) {
        // Note: Supabase doesn't verify current password in admin API
        // This should be handled by re-authenticating the user first
        await this.repository.changePassword(userId, newPassword);
        return { message: 'Password changed successfully' };
    }
    async getTripHistory(userId) {
        return await this.repository.getTripHistory(userId);
    }
    async getStats(userId) {
        const profile = await this.repository.getProfile(userId);
        return {
            tripsCompleted: profile.stats_trips_completed,
            placesVisited: profile.stats_places_visited,
            photosShared: profile.stats_photos_shared,
        };
    }
}
exports.UsersService = UsersService;
//# sourceMappingURL=users.service.js.map