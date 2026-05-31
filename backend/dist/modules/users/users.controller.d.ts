import { Response } from 'express';
export declare class UsersController {
    private service;
    constructor();
    getProfile: (req: import("express").Request, res: Response, next: import("express").NextFunction) => void;
    updateProfile: (req: import("express").Request, res: Response, next: import("express").NextFunction) => void;
    updateSettings: (req: import("express").Request, res: Response, next: import("express").NextFunction) => void;
    changePassword: (req: import("express").Request, res: Response, next: import("express").NextFunction) => void;
    getTripHistory: (req: import("express").Request, res: Response, next: import("express").NextFunction) => void;
    getStats: (req: import("express").Request, res: Response, next: import("express").NextFunction) => void;
}
//# sourceMappingURL=users.controller.d.ts.map