"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TravelersService = void 0;
const AppError_1 = require("../../core/errors/AppError");
const travelers_repository_1 = require("./travelers.repository");
class TravelersService {
    constructor() {
        this.repository = new travelers_repository_1.TravelersRepository();
    }
    async searchTravelers(query, country, interest, page = 1, limit = 20) {
        const offset = (page - 1) * limit;
        const { travelers, count } = await this.repository.searchTravelers(query, country, interest, offset, limit);
        return {
            travelers,
            pagination: {
                page,
                limit,
                total: count,
                totalPages: Math.ceil(count / limit),
            },
        };
    }
    async getTravelerById(travelerId) {
        const traveler = await this.repository.findById(travelerId);
        if (!traveler)
            throw new AppError_1.NotFoundError('Traveler not found');
        return traveler;
    }
    async getOnlineTravelers(limit = 20) {
        return await this.repository.findOnlineTravelers(limit);
    }
}
exports.TravelersService = TravelersService;
//# sourceMappingURL=travelers.service.js.map