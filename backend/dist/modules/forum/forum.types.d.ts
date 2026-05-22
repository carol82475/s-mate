export interface ForumPost {
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
}
export interface ForumComment {
    id: string;
    post_id: string;
    user_id: string;
    content: string;
    created_at: string;
    updated_at: string;
}
export interface ForumPostLike {
    id: string;
    post_id: string;
    user_id: string;
    created_at: string;
}
export interface CreatePostDTO {
    destination: string;
    dates?: string;
    content: string;
    images?: string[];
}
export interface AddCommentDTO {
    text: string;
}
//# sourceMappingURL=forum.types.d.ts.map