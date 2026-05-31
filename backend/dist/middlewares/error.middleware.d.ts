import { Request, Response, NextFunction } from 'express';
import { ZodError } from 'zod';
import { AppError } from '../core/errors/AppError';
export declare const errorHandler: (err: Error | AppError | ZodError, _req: Request, res: Response, _next: NextFunction) => Response<any, Record<string, any>>;
export declare const notFoundHandler: (_req: Request, res: Response) => void;
//# sourceMappingURL=error.middleware.d.ts.map