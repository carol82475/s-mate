import { Album, Photo, PhotoLike } from "./albums.types";
export declare class AlbumsRepository {
    createAlbum(albumData: {
        user_id: string;
        title: string;
        description: string;
        trip_id?: string;
    }): Promise<Album>;
    findAlbumsByUserId(userId: string, tripId?: string): Promise<Album[]>;
    findAlbumById(albumId: string, userId: string): Promise<Album | null>;
    findPhotosByAlbumId(albumId: string): Promise<Photo[]>;
    createPhoto(photoData: {
        user_id: string;
        album_id?: string;
        trip_id?: string;
        image_url: string;
        caption: string;
        metadata?: Record<string, unknown>;
    }): Promise<Photo>;
    updateAlbum(albumId: string, updates: Partial<Album>): Promise<void>;
    findPhotos(userId: string, albumId: string | undefined, offset: number, limit: number): Promise<{
        photos: Photo[];
        count: number;
    }>;
    findPhotoLike(photoId: string, userId: string): Promise<PhotoLike | null>;
    createPhotoLike(photoId: string, userId: string): Promise<void>;
    deletePhotoLike(photoId: string, userId: string): Promise<void>;
    incrementPhotoLikes(photoId: string): Promise<void>;
    decrementPhotoLikes(photoId: string): Promise<void>;
    findPhotoById(photoId: string): Promise<Photo | null>;
    incrementPhotosShared(userId: string): Promise<void>;
}
//# sourceMappingURL=albums.repository.d.ts.map