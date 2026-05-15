import { Router } from 'express';
import * as aiChatController from './ai-chat.controller';
import { authMiddleware } from '../../middlewares/auth.middleware';

const router = Router();

router.use(authMiddleware);

router.post('/message', aiChatController.sendMessage);
router.get('/history', aiChatController.getChatHistory);
router.delete('/history', aiChatController.clearChatHistory);

export default router;
