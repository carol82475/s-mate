import { Trip, TripWithItinerary, Checkpoint } from './trips.types';
export declare class TripsRepository {
    createTrip(tripData: {
        user_id: string;
        destination: string;
        start_date: string;
        end_date: string;
        budget?: number;
        traveler_count: number;
        preferences: string[];
        status: string;
        progress: number;
    }): Promise<Trip>;
    findByUserId(userId: string, status?: string, offset?: number, limit?: number): Promise<{
        trips: Trip[];
        count: number;
    }>;
    findByIdAndUserId(tripId: string, userId: string): Promise<TripWithItinerary | null>;
    updateTrip(tripId: string, userId: string, updates: Partial<Trip>): Promise<Trip | null>;
    deleteTrip(tripId: string, userId: string): Promise<boolean>;
    createItineraryDay(dayData: {
        trip_id: string;
        day_number: number;
        title: string;
        date?: string;
    }): Promise<any>;
    createCheckpoints(checkpoints: Array<{
        itinerary_day_id: string;
        time: string;
        title: string;
        description: string;
        completed: boolean;
        sort_order: number;
    }>): Promise<void>;
    findCheckpointsByTripId(tripId: string): Promise<Checkpoint[]>;
    updateCheckpoint(checkpointId: string, completed: boolean): Promise<void>;
    findCheckpointsByDayIds(dayIds: string[]): Promise<Checkpoint[]>;
}
//# sourceMappingURL=trips.repository.d.ts.map