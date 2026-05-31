import { Request, Response, NextFunction } from 'express';
export interface AuthRequest extends Request {
    user?: {
        id: string;
        email: string;
    };
}
export declare const authMiddleware: (req: Request, res: Response, next: NextFunction) => void;
//# sourceMappingURL=auth.middleware.d.ts.map