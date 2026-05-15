import { Router } from 'express';
import * as travelersController from './travelers.controller';
import { authMiddleware } from '../../middlewares/auth.middleware';

const router = Router();

router.use(authMiddleware);

router.get('/search', travelersController.searchTravelers);
router.get('/online', travelersController.getOnlineTravelers);
router.get('/:id', travelersController.getTravelerById);

export default router;
