import { Response } from 'express';

import { AuthRequest } from '../../middlewares/auth.middleware';
import { TripsService } from './trips.service';
import { asyncHandler } from '../../utils/asyncHandler';
import {
  successResponse,
  paginatedResponse,
} from '../../core/responses/response.helper';

const tripsService = new TripsService();

export const getDestinations = asyncHandler(
  async (_req: AuthRequest, res: Response) => {
    const destinations = await tripsService.getDestinations();

    successResponse(
      res,
      'Destinations retrieved successfully',
      destinations,
    );
  },
);

export const createTrip = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;

    const trip = await tripsService.createTrip(
      userId,
      req.body,
    );

    successResponse(
      res,
      'Trip created successfully',
      trip,
      201,
    );
  },
);

export const getTrips = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { status, page, limit } = req.query;

    const result = await tripsService.getTrips(
      userId,
      status as string,
      parseInt(page as string, 10) || 1,
      parseInt(limit as string, 10) || 10,
    );

    paginatedResponse(
      res,
      'Trips retrieved successfully',
      result.trips,
      result.pagination,
    );
  },
);

export const getTripById = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { id } = req.params;

    const trip = await tripsService.getTripById(
      id,
      userId,
    );

    successResponse(
      res,
      'Trip retrieved successfully',
      trip,
    );
  },
);

export const updateTrip = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { id } = req.params;

    const trip = await tripsService.updateTrip(
      id,
      userId,
      req.body,
    );

    successResponse(
      res,
      'Trip updated successfully',
      trip,
    );
  },
);

export const deleteTrip = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { id } = req.params;

    const result = await tripsService.deleteTrip(
      id,
      userId,
    );

    successResponse(res, result.message);
  },
);

export const updateCheckpoint = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { id } = req.params;
    const { day, checkpointIndex, completed } = req.body;

    const result = await tripsService.updateCheckpoint(
      id,
      userId,
      Number(day),
      Number(checkpointIndex),
      Boolean(completed),
    );

    successResponse(
      res,
      'Checkpoint updated successfully',
      result,
    );
  },
);