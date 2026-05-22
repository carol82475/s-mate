import mongoose, { Document } from 'mongoose';
export interface IPhoto extends Document {
    userId: mongoose.Types.ObjectId;
    albumId?: mongoose.Types.ObjectId;
    tripId?: mongoose.Types.ObjectId;
    url: string;
    thumbnail?: string;
    caption?: string;
    location?: {
        latitude: number;
        longitude: number;
        name: string;
    };
    likes: mongoose.Types.ObjectId[];
    likesCount: number;
    createdAt: Date;
    updatedAt: Date;
}
export declare const Photo: any;
//# sourceMappingURL=Photo.d.ts.map