"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.calculatePagination = exports.getPaginationParams = void 0;
const getPaginationParams = (page, limit) => {
    const parsedPage = typeof page === 'string' ? parseInt(page, 10) : page || 1;
    const parsedLimit = typeof limit === 'string' ? parseInt(limit, 10) : limit || 10;
    return {
        page: Math.max(1, parsedPage),
        limit: Math.min(100, Math.max(1, parsedLimit)),
    };
};
exports.getPaginationParams = getPaginationParams;
const calculatePagination = (page, limit, total) => {
    const totalPages = Math.ceil(total / limit);
    const offset = (page - 1) * limit;
    return {
        page,
        limit,
        total,
        totalPages,
        offset,
    };
};
exports.calculatePagination = calculatePagination;
//# sourceMappingURL=pagination.helper.js.map