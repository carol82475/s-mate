import { Router } from 'express';
import * as forumController from './forum.controller';
import { authMiddleware } from '../../middlewares/auth.middleware';

const router = Router();

router.use(authMiddleware);

router.post('/posts', forumController.createPost);
router.get('/posts', forumController.getPosts);
router.get('/posts/:id', forumController.getPostById);
router.post('/posts/:id/like', forumController.toggleLike);
router.post('/posts/:id/comments', forumController.addComment);
router.post('/posts/:id/share', forumController.sharePost);

export default router;
