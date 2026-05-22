"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.authMiddleware = void 0;
const supabase_1 = require("../config/supabase");
const AppError_1 = require("../core/errors/AppError");
const asyncHandler_1 = require("../utils/asyncHandler");
exports.authMiddleware = (0, asyncHandler_1.asyncHandler)(async (req, _res, next) => {
    const authHeader = req.headers.authorization;
    if (!authHeader ||
        !authHeader.startsWith('Bearer ')) {
        throw new AppError_1.UnauthorizedError('No token provided');
    }
    const token = authHeader
        .replace('Bearer ', '')
        .trim();
    if (!token) {
        throw new AppError_1.UnauthorizedError('Invalid token');
    }
    const { data: { user }, error, } = await supabase_1.supabaseAdmin.auth.getUser(token);
    if (error || !user) {
        throw new AppError_1.UnauthorizedError('Invalid or expired token');
    }
    req.user = {
        id: user.id,
        email: user.email || '',
    };
    next();
});
//# sourceMappingURL=auth.middleware.js.map