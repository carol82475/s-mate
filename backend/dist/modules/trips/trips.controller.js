"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.updateCheckpoint = exports.deleteTrip = exports.updateTrip = exports.getTripById = exports.getTrips = exports.createTrip = exports.getDestinations = void 0;
const trips_service_1 = require("./trips.service");
const asyncHandler_1 = require("../../utils/asyncHandler");
const response_helper_1 = require("../../core/responses/response.helper");
const tripsService = new trips_service_1.TripsService();
exports.getDestinations = (0, asyncHandler_1.asyncHandler)(async (_req, res) => {
    const destinations = await tripsService.getDestinations();
    (0, response_helper_1.successResponse)(res, 'Destinations retrieved successfully', destinations);
});
exports.createTrip = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const trip = await tripsService.createTrip(userId, req.body);
    (0, response_helper_1.successResponse)(res, 'Trip created successfully', trip, 201);
});
exports.getTrips = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { status, page, limit } = req.query;
    const result = await tripsService.getTrips(userId, status, parseInt(page, 10) || 1, parseInt(limit, 10) || 10);
    (0, response_helper_1.paginatedResponse)(res, 'Trips retrieved successfully', result.trips, result.pagination);
});
exports.getTripById = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { id } = req.params;
    const trip = await tripsService.getTripById(id, userId);
    (0, response_helper_1.successResponse)(res, 'Trip retrieved successfully', trip);
});
exports.updateTrip = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { id } = req.params;
    const trip = await tripsService.updateTrip(id, userId, req.body);
    (0, response_helper_1.successResponse)(res, 'Trip updated successfully', trip);
});
exports.deleteTrip = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { id } = req.params;
    const result = await tripsService.deleteTrip(id, userId);
    (0, response_helper_1.successResponse)(res, result.message);
});
exports.updateCheckpoint = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { id } = req.params;
    const { day, checkpointIndex, completed } = req.body;
    const result = await tripsService.updateCheckpoint(id, userId, Number(day), Number(checkpointIndex), Boolean(completed));
    (0, response_helper_1.successResponse)(res, 'Checkpoint updated successfully', result);
});
//# sourceMappingURL=trips.controller.js.map