import { Router } from 'express';
import * as quickActionsController from './quick-actions.controller';
import { authMiddleware } from '../../middlewares/auth.middleware';

const router = Router();

router.use(authMiddleware);

router.get('/', quickActionsController.getQuickActions);

export default router;
