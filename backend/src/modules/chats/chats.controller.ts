import { Response } from 'express';
import { AuthRequest } from '../../middlewares/auth.middleware';
import { ChatsService } from './chats.service';
import { asyncHandler } from '../../utils/asyncHandler';
import { successResponse, paginatedResponse } from '../../core/responses/response.helper';

const chatsService = new ChatsService();

export const getChatRooms = asyncHandler(async (req: AuthRequest, res: Response) => {
  const userId = req.user!.id;
  const rooms = await chatsService.getChatRooms(userId);
  successResponse(res, 'Chat rooms retrieved successfully', rooms);
});

export const getChatRoom = asyncHandler(async (req: AuthRequest, res: Response) => {
  const userId = req.user!.id;
  const { roomId } = req.params;
  const room = await chatsService.getChatRoom(roomId, userId);
  successResponse(res, 'Chat room retrieved successfully', room);
});

export const getOrCreateChatRoom = asyncHandler(async (req: AuthRequest, res: Response) => {
  const userId = req.user!.id;
  const { otherUserId } = req.body;
  const room = await chatsService.getOrCreateChatRoom(userId, otherUserId);
  successResponse(res, 'Chat room retrieved successfully', room);
});

export const getChatMessages = asyncHandler(async (req: AuthRequest, res: Response) => {
  const userId = req.user!.id;
  const { roomId } = req.params;
  const { page, limit } = req.query;
  const result = await chatsService.getChatMessages(
    roomId,
    userId,
    parseInt(page as string) || 1,
    parseInt(limit as string) || 50
  );
  paginatedResponse(res, 'Messages retrieved successfully', result.messages, result.pagination);
});

export const sendMessage = asyncHandler(async (req: AuthRequest, res: Response) => {
  const userId = req.user!.id;
  const { roomId } = req.params;
  const { text, type } = req.body;
  const message = await chatsService.sendMessage(roomId, userId, text, type);
  successResponse(res, 'Message sent successfully', message, 201);
});

export const markMessagesAsRead = asyncHandler(async (req: AuthRequest, res: Response) => {
  const userId = req.user!.id;
  const { roomId } = req.params;
  const result = await chatsService.markMessagesAsRead(roomId, userId);
  successResponse(res, result.message);
});
