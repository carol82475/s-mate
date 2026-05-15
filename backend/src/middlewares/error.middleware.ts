import { Request, Response, NextFunction } from 'express';
import { ZodError } from 'zod';
import { AppError } from '../core/errors/AppError';
import { logger } from '../core/logger/logger';
import { config } from '../config/env';

export const errorHandler = (
  err: Error | AppError | ZodError,
  _req: Request,
  res: Response,
  _next: NextFunction
) => {
  logger.error('Error:', err);

  // Zod validation error
  if (err instanceof ZodError) {
    return res.status(400).json({
      success: false,
      message: 'Validation error',
      error: err.errors.map((e) => `${e.path.join('.')}: ${e.message}`).join(', '),
    });
  }

  // Custom AppError
  if (err instanceof AppError) {
    return res.status(err.statusCode).json({
      success: false,
      message: err.message,
    });
  }

  // Supabase errors
  if (err.message.includes('JWT')) {
    return res.status(401).json({
      success: false,
      message: 'Invalid or expired token',
    });
  }

  // Default error
  return res.status(500).json({
    success: false,
    message: 'Internal server error',
    error: config.env === 'development' ? err.message : undefined,
  });
};

export const notFoundHandler = (_req: Request, res: Response) => {
  res.status(404).json({
    success: false,
    message: `Route not found`,
  });
};
