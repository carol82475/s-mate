import { Router } from 'express';

import {
  getPlans,
  checkout,
} from './purchase.controller';

import { authMiddleware } from '../../middlewares/auth.middleware';

const router = Router();

router.get('/plans', getPlans);

router.post('/checkout', authMiddleware, checkout);

export default router;