import mongoose, { Document } from 'mongoose';
export interface IAlbum extends Document {
    userId: mongoose.Types.ObjectId;
    tripId?: mongoose.Types.ObjectId;
    name: string;
    description?: string;
    coverPhoto?: string;
    photoCount: number;
    createdAt: Date;
    updatedAt: Date;
}
export declare const Album: any;
//# sourceMappingURL=Album.d.ts.map