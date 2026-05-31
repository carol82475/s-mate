import { TravelerProfile } from './travelers.types';
export declare class TravelersRepository {
    searchTravelers(query: string | undefined, country: string | undefined, interest: string | undefined, offset: number, limit: number): Promise<{
        travelers: TravelerProfile[];
        count: number;
    }>;
    findById(travelerId: string): Promise<TravelerProfile | null>;
    findOnlineTravelers(limit: number): Promise<TravelerProfile[]>;
}
//# sourceMappingURL=travelers.repository.d.ts.map