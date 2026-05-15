import { Request, Response } from 'express';
import { MapService } from './map.service';
import { asyncHandler } from '../../utils/asyncHandler';
import { successResponse } from '../../core/responses/response.helper';

const mapService = new MapService();

export const searchPlaces = asyncHandler(async (req: Request, res: Response) => {
  const { query, category, latitude, longitude } = req.query;
  const places = await mapService.searchPlaces(
    query as string,
    category as string,
    latitude ? parseFloat(latitude as string) : undefined,
    longitude ? parseFloat(longitude as string) : undefined
  );
  successResponse(res, 'Places retrieved successfully', places);
});

export const getPlaceById = asyncHandler(async (req: Request, res: Response) => {
  const { id } = req.params;
  const place = await mapService.getPlaceById(id);
  successResponse(res, 'Place retrieved successfully', place);
});

export const getNearbyPlaces = asyncHandler(async (req: Request, res: Response) => {
  const { latitude, longitude, radius } = req.query;
  const places = await mapService.getNearbyPlaces(
    parseFloat(latitude as string),
    parseFloat(longitude as string),
    radius ? parseFloat(radius as string) : undefined
  );
  successResponse(res, 'Nearby places retrieved successfully', places);
});
