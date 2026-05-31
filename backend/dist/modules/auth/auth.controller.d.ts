import { Response } from 'express';
export declare class AuthController {
    private service;
    constructor();
    register: (req: import("express").Request, res: Response, next: import("express").NextFunction) => void;
    login: (req: import("express").Request, res: Response, next: import("express").NextFunction) => void;
    logout: (req: import("express").Request, res: Response, next: import("express").NextFunction) => void;
    getCurrentUser: (req: import("express").Request, res: Response, next: import("express").NextFunction) => void;
    forgotPassword: (req: import("express").Request, res: Response, next: import("express").NextFunction) => void;
}
//# sourceMappingURL=auth.controller.d.ts.map