"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.UsersController = void 0;
const users_service_1 = require("./users.service");
const asyncHandler_1 = require("../../utils/asyncHandler");
const response_helper_1 = require("../../core/responses/response.helper");
class UsersController {
    constructor() {
        this.getProfile = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
            const userId = req.user.id;
            const profile = await this.service.getProfile(userId);
            (0, response_helper_1.successResponse)(res, 'Profile retrieved successfully', profile);
        });
        this.updateProfile = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
            const userId = req.user.id;
            const profile = await this.service.updateProfile(userId, req.body);
            (0, response_helper_1.successResponse)(res, 'Profile updated successfully', profile);
        });
        this.updateSettings = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
            const userId = req.user.id;
            const settings = await this.service.updateSettings(userId, req.body);
            (0, response_helper_1.successResponse)(res, 'Settings updated successfully', settings);
        });
        this.changePassword = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
            const userId = req.user.id;
            const { currentPassword, newPassword } = req.body;
            const result = await this.service.changePassword(userId, currentPassword, newPassword);
            (0, response_helper_1.successResponse)(res, result.message);
        });
        this.getTripHistory = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
            const userId = req.user.id;
            const trips = await this.service.getTripHistory(userId);
            (0, response_helper_1.successResponse)(res, 'Trip history retrieved successfully', trips);
        });
        this.getStats = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
            const userId = req.user.id;
            const stats = await this.service.getStats(userId);
            (0, response_helper_1.successResponse)(res, 'Stats retrieved successfully', stats);
        });
        this.service = new users_service_1.UsersService();
    }
}
exports.UsersController = UsersController;
//# sourceMappingURL=users.controller.js.map