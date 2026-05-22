"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.makeEmergencyCall = exports.getSafetyTips = exports.getQuickPhrases = exports.getEmergencyContacts = void 0;
const emergency_service_1 = require("./emergency.service");
const asyncHandler_1 = require("../../utils/asyncHandler");
const response_helper_1 = require("../../core/responses/response.helper");
const emergencyService = new emergency_service_1.EmergencyService();
exports.getEmergencyContacts = (0, asyncHandler_1.asyncHandler)(async (_req, res) => {
    const contacts = await emergencyService.getEmergencyContacts();
    (0, response_helper_1.successResponse)(res, 'Emergency contacts retrieved successfully', contacts);
});
exports.getQuickPhrases = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const { language } = req.query;
    const phrases = await emergencyService.getQuickPhrases(language);
    (0, response_helper_1.successResponse)(res, 'Quick phrases retrieved successfully', phrases);
});
exports.getSafetyTips = (0, asyncHandler_1.asyncHandler)(async (_req, res) => {
    const tips = await emergencyService.getSafetyTips();
    (0, response_helper_1.successResponse)(res, 'Safety tips retrieved successfully', tips);
});
exports.makeEmergencyCall = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const { type, location } = req.body;
    const result = await emergencyService.makeEmergencyCall(type, location);
    (0, response_helper_1.successResponse)(res, result.message, result);
});
//# sourceMappingURL=emergency.controller.js.map