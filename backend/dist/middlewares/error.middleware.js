"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.notFoundHandler = exports.errorHandler = void 0;
const zod_1 = require("zod");
const AppError_1 = require("../core/errors/AppError");
const logger_1 = require("../core/logger/logger");
const env_1 = require("../config/env");
const errorHandler = (err, _req, res, _next) => {
    logger_1.logger.error('Error:', err);
    // Zod validation error
    if (err instanceof zod_1.ZodError) {
        return res.status(400).json({
            success: false,
            message: 'Validation error',
            error: err.errors.map((e) => `${e.path.join('.')}: ${e.message}`).join(', '),
        });
    }
    // Custom AppError
    if (err instanceof AppError_1.AppError) {
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
        error: env_1.config.env === 'development' ? err.message : undefined,
    });
};
exports.errorHandler = errorHandler;
const notFoundHandler = (_req, res) => {
    res.status(404).json({
        success: false,
        message: `Route not found`,
    });
};
exports.notFoundHandler = notFoundHandler;
//# sourceMappingURL=error.middleware.js.map