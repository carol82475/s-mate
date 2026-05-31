import { AddTripPhotoDTO } from "./albums.types";
export declare class AlbumsService {
    private repository;
    constructor();
    createAlbum(userId: string, name: string, description?: string, tripId?: string): Promise<import("./albums.types").Album>;
    getAlbums(userId: string, tripId?: string): Promise<import("./albums.types").Album[]>;
    getAlbumById(albumId: string, userId: string): Promise<{
        photos: import("./albums.types").Photo[];
        id: string;
        user_id: string;
        trip_id?: string;
        title: string;
        description: string;
        cover_photo_url?: string;
        photo_count: number;
        created_at: string;
        updated_at: string;
    }>;
    addPhotoToAlbum(albumId: string, userId: string, url: string, caption?: string): Promise<import("./albums.types").Photo>;
    addTripPhoto(userId: string, dto: AddTripPhotoDTO): Promise<import("./albums.types").Photo>;
    getPhotos(userId: string, albumId?: string, page?: number, limit?: number): Promise<{
        photos: import("./albums.types").Photo[];
        pagination: {
            page: number;
            limit: number;
            total: number;
            totalPages: number;
        };
    }>;
    togglePhotoLike(photoId: string, userId: string): Promise<{
        message: string;
        liked: boolean;
        likesCount: number;
    }>;
}
//# sourceMappingURL=albums.service.d.ts.map