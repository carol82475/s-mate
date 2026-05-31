import mongoose, { Document } from 'mongoose';
export interface IForumComment {
    userId: mongoose.Types.ObjectId;
    userName: string;
    userAvatar: string;
    text: string;
    createdAt: Date;
}
export interface IForumPost extends Document {
    userId: mongoose.Types.ObjectId;
    userName: string;
    userAvatar: string;
    destination: string;
    content: string;
    images: string[];
    likes: mongoose.Types.ObjectId[];
    likesCount: number;
    comments: IForumComment[];
    commentsCount: number;
    views: number;
    createdAt: Date;
    updatedAt: Date;
}
export declare const ForumPost: any;
//# sourceMappingURL=ForumPost.d.ts.map