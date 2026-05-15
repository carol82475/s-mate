import { Response } from 'express';
import { AuthRequest } from '../../middlewares/auth.middleware';
import { UsersService } from './users.service';
import { asyncHandler } from '../../utils/asyncHandler';
import { successResponse } from '../../core/responses/response.helper';

export class UsersController {
  private service: UsersService;

  constructor() {
    this.service = new UsersService();
  }

  getProfile = asyncHandler(async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const profile = await this.service.getProfile(userId);
    successResponse(res, 'Profile retrieved successfully', profile);
  });

  updateProfile = asyncHandler(async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const profile = await this.service.updateProfile(userId, req.body);
    successResponse(res, 'Profile updated successfully', profile);
  });

  updateSettings = asyncHandler(async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const settings = await this.service.updateSettings(userId, req.body);
    successResponse(res, 'Settings updated successfully', settings);
  });

  changePassword = asyncHandler(async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { currentPassword, newPassword } = req.body;
    const result = await this.service.changePassword(userId, currentPassword, newPassword);
    successResponse(res, result.message);
  });

  getTripHistory = asyncHandler(async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const trips = await this.service.getTripHistory(userId);
    successResponse(res, 'Trip history retrieved successfully', trips);
  });

  getStats = asyncHandler(async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const stats = await this.service.getStats(userId);
    successResponse(res, 'Stats retrieved successfully', stats);
  });
}
