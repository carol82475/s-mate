"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getNearbyPlaces = exports.getPlaceById = exports.searchPlaces = void 0;
const map_service_1 = require("./map.service");
const asyncHandler_1 = require("../../utils/asyncHandler");
const response_helper_1 = require("../../core/responses/response.helper");
const mapService = new map_service_1.MapService();
exports.searchPlaces = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const { query, category, latitude, longitude } = req.query;
    const places = await mapService.searchPlaces(query, category, latitude ? parseFloat(latitude) : undefined, longitude ? parseFloat(longitude) : undefined);
    (0, response_helper_1.successResponse)(res, 'Places retrieved successfully', places);
});
exports.getPlaceById = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const { id } = req.params;
    const place = await mapService.getPlaceById(id);
    (0, response_helper_1.successResponse)(res, 'Place retrieved successfully', place);
});
exports.getNearbyPlaces = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const { latitude, longitude, radius } = req.query;
    const places = await mapService.getNearbyPlaces(parseFloat(latitude), parseFloat(longitude), radius ? parseFloat(radius) : undefined);
    (0, response_helper_1.successResponse)(res, 'Nearby places retrieved successfully', places);
});
//# sourceMappingURL=map.controller.js.map