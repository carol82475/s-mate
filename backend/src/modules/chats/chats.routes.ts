import { Router } from 'express';
import * as chatsController from './chats.controller';
import { authMiddleware } from '../../middlewares/auth.middleware';

const router = Router();

router.use(authMiddleware);

router.get('/rooms', chatsController.getChatRooms);
router.post('/rooms', chatsController.getOrCreateChatRoom);
router.get('/rooms/:roomId', chatsController.getChatRoom);
router.get('/rooms/:roomId/messages', chatsController.getChatMessages);
router.post('/rooms/:roomId/messages', chatsController.sendMessage);
router.patch('/rooms/:roomId/read', chatsController.markMessagesAsRead);

export default router;
