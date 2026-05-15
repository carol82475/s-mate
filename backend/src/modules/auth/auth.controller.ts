import { Response } from 'express';
import { AuthService } from './auth.service';
import { asyncHandler } from '../../utils/asyncHandler';
import { successResponse } from '../../core/responses/response.helper';
import { AuthRequest } from '../../middlewares/auth.middleware';

export class AuthController {
  private service: AuthService;

  constructor() {
    this.service = new AuthService();
  }

  register = asyncHandler(async (req: AuthRequest, res: Response) => {
    const { name, email, password } = req.body;
    const result = await this.service.register({ name, email, password });
    successResponse(res, 'Registration successful', result, 201);
  });

  login = asyncHandler(async (req: AuthRequest, res: Response) => {
    const { email, password } = req.body;
    const result = await this.service.login({ email, password });
    successResponse(res, 'Login successful', result);
  });

  logout = asyncHandler(async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    await this.service.logout(userId);
    successResponse(res, 'Logged out successfully');
  });

  getCurrentUser = asyncHandler(async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const user = await this.service.getCurrentUser(userId);
    successResponse(res, 'User retrieved successfully', user);
  });

  forgotPassword = asyncHandler(async (req: AuthRequest, res: Response) => {
    const { email } = req.body;
    const result = await this.service.forgotPassword(email);
    successResponse(res, result.message);
  });
}
