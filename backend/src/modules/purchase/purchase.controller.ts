import { Request, Response } from 'express';

import { asyncHandler } from '../../utils/asyncHandler';
import { successResponse } from '../../core/responses/response.helper';

export const getPlans = asyncHandler(async (_req: Request, res: Response) => {
  successResponse(res, 'Plans retrieved successfully', [
    {
      id: 'basic',
      name: 'Basic Plan',
      duration: '7 Days',
      price: 15,
      popular: false,
      features: ['Unlimited Planning', 'Full Map Access', 'Forum Access'],
    },
    {
      id: 'premium',
      name: 'Premium Plan',
      duration: '14 Days',
      price: 25,
      popular: true,
      features: ['Unlimited Planning', 'AI Suggestions', 'Premium Features'],
    },
    {
      id: 'pro',
      name: 'Pro Plan',
      duration: '30 Days',
      price: 39,
      popular: false,
      features: ['Everything in Premium', 'Priority Support'],
    },
  ]);
});

export const checkout = asyncHandler(async (req: Request, res: Response) => {
  const { planId, planName, amount, currency, paymentMethod } = req.body;

  successResponse(
    res,
    'Payment successful',
    {
      payment_id: Date.now().toString(),
      planId,
      planName,
      amount,
      currency,
      paymentMethod,
      status: 'completed',
    },
    201,
  );
});