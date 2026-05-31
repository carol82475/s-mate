"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getOnlineTravelers = exports.getTravelerById = exports.searchTravelers = void 0;
const travelers_service_1 = require("./travelers.service");
const asyncHandler_1 = require("../../utils/asyncHandler");
const response_helper_1 = require("../../core/responses/response.helper");
const travelersService = new travelers_service_1.TravelersService();
exports.searchTravelers = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const { query, country, interest, page, limit } = req.query;
    const result = await travelersService.searchTravelers(query, country, interest, parseInt(page) || 1, parseInt(limit) || 20);
    (0, response_helper_1.paginatedResponse)(res, 'Travelers retrieved successfully', result.travelers, result.pagination);
});
exports.getTravelerById = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const { id } = req.params;
    const traveler = await travelersService.getTravelerById(id);
    (0, response_helper_1.successResponse)(res, 'Traveler retrieved successfully', traveler);
});
exports.getOnlineTravelers = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const { limit } = req.query;
    const travelers = await travelersService.getOnlineTravelers(limit ? parseInt(limit) : undefined);
    (0, response_helper_1.successResponse)(res, 'Online travelers retrieved successfully', travelers);
});
//# sourceMappingURL=travelers.controller.js.map