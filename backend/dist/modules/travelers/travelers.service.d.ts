export declare class TravelersService {
    private repository;
    constructor();
    searchTravelers(query?: string, country?: string, interest?: string, page?: number, limit?: number): Promise<{
        travelers: import("./travelers.types").TravelerProfile[];
        pagination: {
            page: number;
            limit: number;
            total: number;
            totalPages: number;
        };
    }>;
    getTravelerById(travelerId: string): Promise<import("./travelers.types").TravelerProfile>;
    getOnlineTravelers(limit?: number): Promise<import("./travelers.types").TravelerProfile[]>;
}
//# sourceMappingURL=travelers.service.d.ts.map