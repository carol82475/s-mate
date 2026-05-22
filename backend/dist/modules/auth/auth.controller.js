"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthController = void 0;
const auth_service_1 = require("./auth.service");
const asyncHandler_1 = require("../../utils/asyncHandler");
const response_helper_1 = require("../../core/responses/response.helper");
class AuthController {
    constructor() {
        this.register = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
            const { name, email, password } = req.body;
            const result = await this.service.register({ name, email, password });
            (0, response_helper_1.successResponse)(res, 'Registration successful', result, 201);
        });
        this.login = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
            const { email, password } = req.body;
            const result = await this.service.login({ email, password });
            (0, response_helper_1.successResponse)(res, 'Login successful', result);
        });
        this.logout = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
            const userId = req.user.id;
            await this.service.logout(userId);
            (0, response_helper_1.successResponse)(res, 'Logged out successfully');
        });
        this.getCurrentUser = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
            const userId = req.user.id;
            const user = await this.service.getCurrentUser(userId);
            (0, response_helper_1.successResponse)(res, 'User retrieved successfully', user);
        });
        this.forgotPassword = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
            const { email } = req.body;
            const result = await this.service.forgotPassword(email);
            (0, response_helper_1.successResponse)(res, result.message);
        });
        this.service = new auth_service_1.AuthService();
    }
}
exports.AuthController = AuthController;
//# sourceMappingURL=auth.controller.js.map