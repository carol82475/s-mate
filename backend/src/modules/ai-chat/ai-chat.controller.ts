import { Response } from 'express';
import { AuthRequest } from '../../middlewares/auth.middleware';
import { AiChatService } from './ai-chat.service';
import { asyncHandler } from '../../utils/asyncHandler';
import { successResponse } from '../../core/responses/response.helper';

const aiChatService = new AiChatService();

export const sendMessage = asyncHandler(async (req: AuthRequest, res: Response) => {
  const userId = req.user!.id;
  const { message } = req.body;
  const response = await aiChatService.sendMessage(userId, message);
  successResponse(res, 'Message sent successfully', response);
});

export const getChatHistory = asyncHandler(async (req: AuthRequest, res: Response) => {
  const userId = req.user!.id;
  const { limit } = req.query;
  const history = await aiChatService.getChatHistory(
    userId,
    limit ? parseInt(limit as string) : undefined
  );
  successResponse(res, 'Chat history retrieved successfully', history);
});

export const clearChatHistory = asyncHandler(async (req: AuthRequest, res: Response) => {
  const userId = req.user!.id;
  const result = await aiChatService.clearChatHistory(userId);
  successResponse(res, result.message);
});
