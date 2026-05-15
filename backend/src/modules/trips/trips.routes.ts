import { Router } from 'express';
import * as tripsController from './trips.controller';
import { authMiddleware } from '../../middlewares/auth.middleware';
import { validate } from '../../middlewares/validate.middleware';
import { createTripSchema, updateTripSchema } from './trips.validation';

const router = Router();

router.get('/destinations', tripsController.getDestinations);

router.use(authMiddleware);

router.post('/', validate(createTripSchema), tripsController.createTrip);
router.get('/', tripsController.getTrips);
router.get('/:id', tripsController.getTripById);
router.put('/:id', validate(updateTripSchema), tripsController.updateTrip);
router.delete('/:id', tripsController.deleteTrip);
router.patch('/:id/checkpoint', tripsController.updateCheckpoint);

export default router;