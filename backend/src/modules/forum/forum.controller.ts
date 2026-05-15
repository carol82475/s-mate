import { Response } from 'express';

import { AuthRequest } from '../../middlewares/auth.middleware';
import { ForumService } from './forum.service';
import { asyncHandler } from '../../utils/asyncHandler';
import {
  successResponse,
  paginatedResponse,
} from '../../core/responses/response.helper';

const forumService = new ForumService();

export const createPost = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { destination, dates, content, images } = req.body;

    const post = await forumService.createPost(
      userId,
      destination,
      content,
      images,
      dates,
    );

    successResponse(
      res,
      'Post created successfully',
      post,
      201,
    );
  },
);

export const getPosts = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const { sort, page, limit } = req.query;

    const result = await forumService.getPosts(
      sort as string,
      parseInt(page as string, 10) || 1,
      parseInt(limit as string, 10) || 10,
    );

    paginatedResponse(
      res,
      'Posts retrieved successfully',
      result.posts,
      result.pagination,
    );
  },
);

export const getPostById = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const { id } = req.params;

    const post = await forumService.getPostById(id);

    successResponse(
      res,
      'Post retrieved successfully',
      post,
    );
  },
);

export const toggleLike = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { id } = req.params;

    const result = await forumService.toggleLike(
      id,
      userId,
    );

    successResponse(
      res,
      result.message,
      {
        liked: result.liked,
        likesCount: result.likesCount,
      },
    );
  },
);

export const addComment = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { id } = req.params;
    const { text } = req.body;

    const comment = await forumService.addComment(
      id,
      userId,
      text,
    );

    successResponse(
      res,
      'Comment added successfully',
      comment,
      201,
    );
  },
);

export const sharePost = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const { id } = req.params;

    const result = await forumService.sharePost(id);

    successResponse(res, result.message);
  },
);