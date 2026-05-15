import { NotFoundError } from '../../core/errors/AppError';
import { ForumRepository } from './forum.repository';

export class ForumService {
  private repository: ForumRepository;

  constructor() {
    this.repository = new ForumRepository();
  }

  async createPost(
    userId: string,
    destination: string,
    content: string,
    images?: string[],
    dates?: string
  ) {
    const profile = await this.repository.findProfileById(userId);

    const post = await this.repository.createPost({
      user_id: userId,
      destination,
      dates,
      content,
      images: images || [],
    });

    return {
      ...post,
      user_name: profile?.full_name,
      user_avatar: profile?.avatar_url,
    };
  }

  async getPosts(sort = 'latest', page = 1, limit = 10) {
    const offset = (page - 1) * limit;

    const { posts, count } = await this.repository.findPosts(
      sort,
      offset,
      limit
    );

    return {
      posts,
      pagination: {
        page,
        limit,
        total: count,
        totalPages: Math.ceil(count / limit),
      },
    };
  }

  async getPostById(postId: string) {
    const post = await this.repository.findPostById(postId);

    if (!post) {
      throw new NotFoundError('Post not found');
    }

    await this.repository.incrementViews(postId, post.views || 0);

    return post;
  }

  async toggleLike(postId: string, userId: string) {
    const existingLike = await this.repository.findLike(postId, userId);

    let liked = false;

    if (existingLike) {
      await this.repository.deleteLike(postId, userId);
      await this.repository.decrementLikes(postId);
    } else {
      await this.repository.createLike(postId, userId);
      await this.repository.incrementLikes(postId);
      liked = true;
    }

    const post = await this.repository.findPostById(postId);

    return {
      message: liked ? 'Post liked' : 'Post unliked',
      liked,
      likesCount: post?.likes_count || 0,
    };
  }

  async addComment(postId: string, userId: string, text: string) {
    const comment = await this.repository.createComment({
      post_id: postId,
      user_id: userId,
      content: text,
    });

    await this.repository.incrementComments(postId);

    return comment;
  }

  async sharePost(postId: string) {
    const post = await this.repository.findPostById(postId);

    if (!post) {
      throw new NotFoundError('Post not found');
    }

    return {
      message: 'Post shared successfully',
    };
  }
}