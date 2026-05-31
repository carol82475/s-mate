export interface Database {
    public: {
        Tables: {
            profiles: {
                Row: {
                    id: string;
                    full_name: string;
                    avatar_url: string | null;
                    country: string | null;
                    bio: string | null;
                    interests: string[];
                    language: string;
                    notifications_enabled: boolean;
                    privacy_show_online: boolean;
                    privacy_show_location: boolean;
                    stats_trips_completed: number;
                    stats_places_visited: number;
                    stats_photos_shared: number;
                    is_online: boolean;
                    last_seen: string;
                    created_at: string;
                    updated_at: string;
                };
                Insert: {
                    id: string;
                    full_name: string;
                    avatar_url?: string | null;
                    country?: string | null;
                    bio?: string | null;
                    interests?: string[];
                    language?: string;
                    notifications_enabled?: boolean;
                    privacy_show_online?: boolean;
                    privacy_show_location?: boolean;
                };
                Update: {
                    full_name?: string;
                    avatar_url?: string | null;
                    country?: string | null;
                    bio?: string | null;
                    interests?: string[];
                    language?: string;
                    notifications_enabled?: boolean;
                    privacy_show_online?: boolean;
                    privacy_show_location?: boolean;
                    is_online?: boolean;
                    last_seen?: string;
                };
            };
            trips: {
                Row: {
                    id: string;
                    user_id: string;
                    destination: string;
                    start_date: string;
                    end_date: string;
                    budget: number;
                    traveler_count: number;
                    preferences: any;
                    status: string;
                    progress: number;
                    created_at: string;
                    updated_at: string;
                };
                Insert: {
                    user_id: string;
                    destination: string;
                    start_date: string;
                    end_date: string;
                    budget: number;
                    traveler_count: number;
                    preferences?: any;
                    status?: string;
                    progress?: number;
                };
                Update: {
                    destination?: string;
                    start_date?: string;
                    end_date?: string;
                    budget?: number;
                    traveler_count?: number;
                    preferences?: any;
                    status?: string;
                    progress?: number;
                };
            };
        };
    };
}
export interface AuthUser {
    id: string;
    email: string;
    user_metadata?: {
        full_name?: string;
        avatar_url?: string;
    };
}
//# sourceMappingURL=supabase.types.d.ts.map