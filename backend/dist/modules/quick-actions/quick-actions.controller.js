"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getQuickActions = void 0;
const quick_actions_service_1 = require("./quick-actions.service");
const asyncHandler_1 = require("../../utils/asyncHandler");
const response_helper_1 = require("../../core/responses/response.helper");
const quickActionsService = new quick_actions_service_1.QuickActionsService();
exports.getQuickActions = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const actions = await quickActionsService.getQuickActions(userId);
    (0, response_helper_1.successResponse)(res, 'Quick actions retrieved successfully', actions);
});
//# sourceMappingURL=quick-actions.controller.js.map