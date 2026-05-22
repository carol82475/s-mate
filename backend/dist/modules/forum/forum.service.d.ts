export declare class ForumService {
    private repository;
    constructor();
    createPost(userId: string, destination: string, content: string, images?: string[], dates?: string): Promise<{
        user_name: any;
        user_avatar: any;
        id: string;
        user_id: string;
        destination: string;
        dates?: string;
        content: string;
        images: string[];
        likes_count: number;
        comments_count: number;
        views: number;
        created_at: string;
        updated_at: string;
    }>;
    getPosts(sort?: string, page?: number, limit?: number): Promise<{
        posts: import("./forum.types").ForumPost[];
        pagination: {
            page: number;
            limit: number;
            total: number;
            totalPages: number;
        };
    }>;
    getPostById(postId: string): Promise<import("./forum.types").ForumPost>;
    toggleLike(postId: string, userId: string): Promise<{
        message: string;
        liked: boolean;
        likesCount: number;
    }>;
    addComment(postId: string, userId: string, text: string): Promise<import("./forum.types").ForumComment>;
    sharePost(postId: string): Promise<{
        message: string;
    }>;
}
//# sourceMappingURL=forum.service.d.ts.map