import { Response } from 'express';
export interface ApiResponse<T = any> {
    success: boolean;
    message: string;
    data?: T;
    pagination?: {
        page: number;
        limit: number;
        total: number;
        totalPages: number;
    };
}
export interface ErrorResponse {
    success: false;
    message: string;
    error?: string;
}
export declare const successResponse: <T>(res: Response, message: string, data?: T, statusCode?: number) => Response;
export declare const paginatedResponse: <T>(res: Response, message: string, data: T[], pagination: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
}, statusCode?: number) => Response;
export declare const errorResponse: (res: Response, message: string, statusCode?: number, error?: string) => Response;
//# sourceMappingURL=response.helper.d.ts.map