"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.errorResponse = exports.paginatedResponse = exports.successResponse = void 0;
const successResponse = (res, message, data, statusCode = 200) => {
    const response = {
        success: true,
        message,
        ...(data !== undefined && { data }),
    };
    return res.status(statusCode).json(response);
};
exports.successResponse = successResponse;
const paginatedResponse = (res, message, data, pagination, statusCode = 200) => {
    const response = {
        success: true,
        message,
        data,
        pagination,
    };
    return res.status(statusCode).json(response);
};
exports.paginatedResponse = paginatedResponse;
const errorResponse = (res, message, statusCode = 400, error) => {
    const response = {
        success: false,
        message,
        ...(error && { error }),
    };
    return res.status(statusCode).json(response);
};
exports.errorResponse = errorResponse;
//# sourceMappingURL=response.helper.js.map