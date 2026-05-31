"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.notFoundHandler = exports.errorHandler = exports.AppError = void 0;
const zod_1 = require("zod");
class AppError extends Error {
    constructor(statusCode, message, isOperational = true) {
        super(message);
        this.statusCode = statusCode;
        this.message = message;
        this.isOperational = isOperational;
        Object.setPrototypeOf(this, AppError.prototype);
    }
}
exports.AppError = AppError;
const errorHandler = (err, _req, res, _next) => {
    console.error('Error:', err);
    // Zod validation error
    if (err instanceof zod_1.ZodError) {
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
    // Mongoose validation error
    if (err.name === 'ValidationError') {
        return res.status(400).json({
            success: false,
            message: 'Validation error',
            error: err.message,
        });
    }
    // Mongoose duplicate key error
    if (err.name === 'MongoServerError' && err.code === 11000) {
        return res.status(409).json({
            success: false,
            message: 'Duplicate entry',
            error: 'A record with this value already exists',
        });
    }
    // JWT errors
    if (err.name === 'JsonWebTokenError') {
        return res.status(401).json({
            success: false,
            message: 'Invalid token',
        });
    }
    if (err.name === 'TokenExpiredError') {
        return res.status(401).json({
            success: false,
            message: 'Token expired',
        });
    }
    // Default error
    return res.status(500).json({
        success: false,
        message: 'Internal server error',
        error: process.env.NODE_ENV === 'development' ? err.message : undefined,
    });
};
exports.errorHandler = errorHandler;
const notFoundHandler = (req, res) => {
    res.status(404).json({
        success: false,
        message: `Route ${req.originalUrl} not found`,
    });
};
exports.notFoundHandler = notFoundHandler;
//# sourceMappingURL=errorHandler.js.map