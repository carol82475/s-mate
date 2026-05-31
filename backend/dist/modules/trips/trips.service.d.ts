import { CreateTripDTO, UpdateTripDTO } from './trips.types';
export declare class TripsService {
    private repository;
    constructor();
    getDestinations(): Promise<string[]>;
    createTrip(userId: string, tripData: CreateTripDTO): Promise<import("./trips.types").TripWithItinerary | null>;
    getTrips(userId: string, status?: string, page?: number, limit?: number): Promise<{
        trips: import("./trips.types").Trip[];
        pagination: {
            page: number;
            limit: number;
            total: number;
            totalPages: number;
        };
    }>;
    getTripById(tripId: string, userId: string): Promise<import("./trips.types").TripWithItinerary>;
    updateTrip(tripId: string, userId: string, updates: UpdateTripDTO): Promise<import("./trips.types").Trip>;
    deleteTrip(tripId: string, userId: string): Promise<{
        message: string;
    }>;
    updateCheckpoint(tripId: string, userId: string, day: number, checkpointIndex: number, completed: boolean): Promise<{
        progress: number;
        completed: boolean;
    }>;
    private generateMockItinerary;
}
//# sourceMappingURL=trips.service.d.ts.map