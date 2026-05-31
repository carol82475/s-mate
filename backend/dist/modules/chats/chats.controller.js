"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.markMessagesAsRead = exports.sendMessage = exports.getChatMessages = exports.getOrCreateChatRoom = exports.getChatRoom = exports.getChatRooms = void 0;
const chats_service_1 = require("./chats.service");
const asyncHandler_1 = require("../../utils/asyncHandler");
const response_helper_1 = require("../../core/responses/response.helper");
const chatsService = new chats_service_1.ChatsService();
exports.getChatRooms = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const rooms = await chatsService.getChatRooms(userId);
    (0, response_helper_1.successResponse)(res, 'Chat rooms retrieved successfully', rooms);
});
exports.getChatRoom = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { roomId } = req.params;
    const room = await chatsService.getChatRoom(roomId, userId);
    (0, response_helper_1.successResponse)(res, 'Chat room retrieved successfully', room);
});
exports.getOrCreateChatRoom = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { otherUserId } = req.body;
    const room = await chatsService.getOrCreateChatRoom(userId, otherUserId);
    (0, response_helper_1.successResponse)(res, 'Chat room retrieved successfully', room);
});
exports.getChatMessages = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { roomId } = req.params;
    const { page, limit } = req.query;
    const result = await chatsService.getChatMessages(roomId, userId, parseInt(page) || 1, parseInt(limit) || 50);
    (0, response_helper_1.paginatedResponse)(res, 'Messages retrieved successfully', result.messages, result.pagination);
});
exports.sendMessage = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { roomId } = req.params;
    const { text, type } = req.body;
    const message = await chatsService.sendMessage(roomId, userId, text, type);
    (0, response_helper_1.successResponse)(res, 'Message sent successfully', message, 201);
});
exports.markMessagesAsRead = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { roomId } = req.params;
    const result = await chatsService.markMessagesAsRead(roomId, userId);
    (0, response_helper_1.successResponse)(res, result.message);
});
//# sourceMappingURL=chats.controller.js.map