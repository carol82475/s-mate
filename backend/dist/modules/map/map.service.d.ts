export declare class MapService {
    searchPlaces(query?: string, category?: string, _latitude?: number, _longitude?: number): Promise<{
        id: string;
        name: string;
        category: string;
        rating: number;
        distance: string;
        latitude: number;
        longitude: number;
        address: string;
        description: string;
    }[]>;
    getPlaceById(placeId: string): Promise<{
        id: string;
        name: string;
        category: string;
        rating: number;
        distance: string;
        latitude: number;
        longitude: number;
        address: string;
        description: string;
        openingHours: string;
        phone: string;
        website: string;
        photos: string[];
        reviews: {
            userName: string;
            rating: number;
            comment: string;
            date: Date;
        }[];
    }>;
    getNearbyPlaces(_latitude: number, _longitude: number, _radius?: number): Promise<{
        id: string;
        name: string;
        category: string;
        rating: number;
        distance: string;
        latitude: number;
        longitude: number;
        address: string;
        description: string;
    }[]>;
}
//# sourceMappingURL=map.service.d.ts.map