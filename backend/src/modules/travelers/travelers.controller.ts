import { Request, Response } from 'express';
import { TravelersService } from './travelers.service';
import { asyncHandler } from '../../utils/asyncHandler';
import { successResponse, paginatedResponse } from '../../core/responses/response.helper';

const travelersService = new TravelersService();

export const searchTravelers = asyncHandler(async (req: Request, res: Response) => {
  const { query, country, interest, page, limit } = req.query;
  const result = await travelersService.searchTravelers(
    query as string,
    country as string,
    interest as string,
    parseInt(page as string) || 1,
    parseInt(limit as string) || 20
  );
  paginatedResponse(res, 'Travelers retrieved successfully', result.travelers, result.pagination);
});

export const getTravelerById = asyncHandler(async (req: Request, res: Response) => {
  const { id } = req.params;
  const traveler = await travelersService.getTravelerById(id);
  successResponse(res, 'Traveler retrieved successfully', traveler);
});

export const getOnlineTravelers = asyncHandler(async (req: Request, res: Response) => {
  const { limit } = req.query;
  const travelers = await travelersService.getOnlineTravelers(
    limit ? parseInt(limit as string) : undefined
  );
  successResponse(res, 'Online travelers retrieved successfully', travelers);
});
