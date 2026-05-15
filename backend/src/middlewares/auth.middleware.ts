import {
  Request,
  Response,
  NextFunction,
} from 'express';

import { supabaseAdmin } from '../config/supabase';

import { UnauthorizedError } from '../core/errors/AppError';
import { asyncHandler } from '../utils/asyncHandler';

export interface AuthRequest extends Request {
  user?: {
    id: string;
    email: string;
  };
}

export const authMiddleware = asyncHandler(
  async (
    req: AuthRequest,
    _res: Response,
    next: NextFunction,
  ) => {
    const authHeader = req.headers.authorization;

    if (
      !authHeader ||
      !authHeader.startsWith('Bearer ')
    ) {
      throw new UnauthorizedError(
        'No token provided',
      );
    }

    const token = authHeader
      .replace('Bearer ', '')
      .trim();

    if (!token) {
      throw new UnauthorizedError(
        'Invalid token',
      );
    }

    const {
      data: { user },
      error,
    } = await supabaseAdmin.auth.getUser(token);

    if (error || !user) {
      throw new UnauthorizedError(
        'Invalid or expired token',
      );
    }

    req.user = {
      id: user.id,
      email: user.email || '',
    };

    next();
  },
);