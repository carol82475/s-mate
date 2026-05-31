import { Request, Response, NextFunction } from 'express';
import { ZodError } from 'zod';
export declare class AppError extends Error {
    statusCode: number;
    message: string;
    isOperational: boolean;
    constructor(statusCode: number, message: string, isOperational?: boolean);
}
export declare const errorHandler: (err: Error | AppError | ZodError, _req: Request, res: Response, _next: NextFunction) => Response<any, Record<string, any>>;
export declare const notFoundHandler: (req: Request, res: Response) => void;
//# sourceMappingURL=errorHandler.d.ts.map