"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.clearChatHistory = exports.getChatHistory = exports.sendMessage = void 0;
const ai_chat_service_1 = require("./ai-chat.service");
const asyncHandler_1 = require("../../utils/asyncHandler");
const response_helper_1 = require("../../core/responses/response.helper");
const aiChatService = new ai_chat_service_1.AiChatService();
exports.sendMessage = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { message } = req.body;
    const response = await aiChatService.sendMessage(userId, message);
    (0, response_helper_1.successResponse)(res, 'Message sent successfully', response);
});
exports.getChatHistory = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { limit } = req.query;
    const history = await aiChatService.getChatHistory(userId, limit ? parseInt(limit) : undefined);
    (0, response_helper_1.successResponse)(res, 'Chat history retrieved successfully', history);
});
exports.clearChatHistory = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const result = await aiChatService.clearChatHistory(userId);
    (0, response_helper_1.successResponse)(res, result.message);
});
//# sourceMappingURL=ai-chat.controller.js.map