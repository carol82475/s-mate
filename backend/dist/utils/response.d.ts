import { Response } from 'express';
export interface ApiResponse<T = any> {
    success: boolean;
    message: string;
    data?: T;
    error?: string;
}
export declare const sendSuccess: <T>(res: Response, message: string, data?: T, statusCode?: number) => Response;
export declare const sendError: (res: Response, message: string, statusCode?: number, error?: string) => Response;
//# sourceMappingURL=response.d.ts.map