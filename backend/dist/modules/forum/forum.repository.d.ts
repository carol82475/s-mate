import { ForumPost, ForumComment, ForumPostLike } from './forum.types';
export declare class ForumRepository {
    createPost(postData: {
        user_id: string;
        destination: string;
        dates?: string;
        content: string;
        images: string[];
    }): Promise<ForumPost>;
    findPosts(sort: string, offset: number, limit: number): Promise<{
        posts: ForumPost[];
        count: number;
    }>;
    findPostById(postId: string): Promise<ForumPost | null>;
    incrementViews(postId: string, currentViews: number): Promise<void>;
    findLike(postId: string, userId: string): Promise<ForumPostLike | null>;
    createLike(postId: string, userId: string): Promise<void>;
    deleteLike(postId: string, userId: string): Promise<void>;
    incrementLikes(postId: string): Promise<void>;
    decrementLikes(postId: string): Promise<void>;
    createComment(commentData: {
        post_id: string;
        user_id: string;
        content: string;
    }): Promise<ForumComment>;
    incrementComments(postId: string): Promise<void>;
    findProfileById(userId: string): Promise<{
        full_name: any;
        avatar_url: any;
    } | null>;
}
//# sourceMappingURL=forum.repository.d.ts.map