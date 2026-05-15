import { Request, Response } from 'express';
import { EmergencyService } from './emergency.service';
import { asyncHandler } from '../../utils/asyncHandler';
import { successResponse } from '../../core/responses/response.helper';

const emergencyService = new EmergencyService();

export const getEmergencyContacts = asyncHandler(async (_req: Request, res: Response) => {
  const contacts = await emergencyService.getEmergencyContacts();
  successResponse(res, 'Emergency contacts retrieved successfully', contacts);
});

export const getQuickPhrases = asyncHandler(async (req: Request, res: Response) => {
  const { language } = req.query;
  const phrases = await emergencyService.getQuickPhrases(language as string);
  successResponse(res, 'Quick phrases retrieved successfully', phrases);
});

export const getSafetyTips = asyncHandler(async (_req: Request, res: Response) => {
  const tips = await emergencyService.getSafetyTips();
  successResponse(res, 'Safety tips retrieved successfully', tips);
});

export const makeEmergencyCall = asyncHandler(async (req: Request, res: Response) => {
  const { type, location } = req.body;
  const result = await emergencyService.makeEmergencyCall(type, location);
  successResponse(res, result.message, result);
});
