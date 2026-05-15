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

export const getPaginationParams = (
  page?: string | number,
  limit?: string | number
): PaginationParams => {
  const parsedPage = typeof page === 'string' ? parseInt(page, 10) : page || 1;
  const parsedLimit = typeof limit === 'string' ? parseInt(limit, 10) : limit || 10;

  return {
    page: Math.max(1, parsedPage),
    limit: Math.min(100, Math.max(1, parsedLimit)),
  };
};

export const calculatePagination = (
  page: number,
  limit: number,
  total: number
): PaginationResult => {
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
