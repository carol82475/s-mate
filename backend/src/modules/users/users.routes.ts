import { Router } from 'express';
import { UsersController } from './users.controller';
import { authMiddleware } from '../../middlewares/auth.middleware';
import { validate } from '../../middlewares/validate.middleware';
import {
  updateProfileSchema,
  updateSettingsSchema,
  changePasswordSchema,
} from './users.validation';

const router = Router();
const controller = new UsersController();

router.use(authMiddleware);

router.get('/profile', controller.getProfile);
router.put('/profile', validate(updateProfileSchema), controller.updateProfile);
router.put('/settings', validate(updateSettingsSchema), controller.updateSettings);
router.post('/change-password', validate(changePasswordSchema), controller.changePassword);
router.get('/trip-history', controller.getTripHistory);
router.get('/stats', controller.getStats);

export default router;
