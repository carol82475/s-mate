export interface ProfileResponse {
  id: string;
  name: string;
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
  lastSeen: string;
}

export interface UpdateProfileDto {
  name?: string;
  avatar?: string;
  country?: string;
  bio?: string;
  interests?: string[];
}

export interface UpdateSettingsDto {
  language?: string;
  notificationsEnabled?: boolean;
  privacySettings?: {
    showOnlineStatus?: boolean;
    showLocation?: boolean;
  };
}

export interface ChangePasswordDto {
  currentPassword: string;
  newPassword: string;
}
