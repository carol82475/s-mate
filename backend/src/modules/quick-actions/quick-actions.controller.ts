import { Response } from 'express';
import { AuthRequest } from '../../middlewares/auth.middleware';
import { QuickActionsService } from './quick-actions.service';
import { asyncHandler } from '../../utils/asyncHandler';
import { successResponse } from '../../core/responses/response.helper';

const quickActionsService = new QuickActionsService();

export const getQuickActions = asyncHandler(async (req: AuthRequest, res: Response) => {
  const userId = req.user!.id;
  const actions = await quickActionsService.getQuickActions(userId);
  successResponse(res, 'Quick actions retrieved successfully', actions);
});
