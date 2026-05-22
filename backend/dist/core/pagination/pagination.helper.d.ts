export interface PaginationParams {
    page: number;
    limit: number;
}
export interface PaginationResult {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
    offset: number;
}
export declare const getPaginationParams: (page?: string | number, limit?: string | number) => PaginationParams;
export declare const calculatePagination: (page: number, limit: number, total: number) => PaginationResult;
//# sourceMappingURL=pagination.helper.d.ts.map