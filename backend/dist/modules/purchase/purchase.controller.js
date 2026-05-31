"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.checkout = exports.getPlans = void 0;
const asyncHandler_1 = require("../../utils/asyncHandler");
const response_helper_1 = require("../../core/responses/response.helper");
exports.getPlans = (0, asyncHandler_1.asyncHandler)(async (_req, res) => {
    (0, response_helper_1.successResponse)(res, 'Plans retrieved successfully', [
        {
            id: 'basic',
            name: 'Basic Plan',
            duration: '7 Days',
            price: 15,
            popular: false,
            features: ['Unlimited Planning', 'Full Map Access', 'Smart AI Suggestions'],
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
exports.checkout = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const { planId, planName, amount, currency, paymentMethod } = req.body;
    (0, response_helper_1.successResponse)(res, 'Payment successful', {
        payment_id: Date.now().toString(),
        planId,
        planName,
        amount,
        currency,
        paymentMethod,
        status: 'completed',
    }, 201);
});
