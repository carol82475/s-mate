"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AlbumsService = void 0;
const AppError_1 = require("../../core/errors/AppError");
const albums_repository_1 = require("./albums.repository");
class AlbumsService {
    constructor() {
        this.repository = new albums_repository_1.AlbumsRepository();
    }
    async createAlbum(userId, name, description, tripId) {
        return await this.repository.createAlbum({
            user_id: userId,
            title: name,
            description: description || "",
            trip_id: tripId || undefined,
        });
    }
    async getAlbums(userId, tripId) {
        return await this.repository.findAlbumsByUserId(userId, tripId);
    }
    async getAlbumById(albumId, userId) {
        const album = await this.repository.findAlbumById(albumId, userId);
        if (!album)
            throw new AppError_1.NotFoundError("Album not found");
        const photos = await this.repository.findPhotosByAlbumId(albumId);
        return {
            ...album,
            photos,
        };
    }
    async addPhotoToAlbum(albumId, userId, url, caption) {
        const album = await this.repository.findAlbumById(albumId, userId);
        if (!album)
            throw new AppError_1.NotFoundError("Album not found");
        const photo = await this.repository.createPhoto({
            user_id: userId,
            album_id: albumId,
            trip_id: album.trip_id,
            image_url: url,
            caption: caption || "",
        });
        // Update album photo count and cover photo
        const newPhotoCount = (album.photo_count || 0) + 1;
        await this.repository.updateAlbum(albumId, {
            photo_count: newPhotoCount,
            cover_photo_url: album.cover_photo_url || url,
        });
        // Update user stats
        await this.repository.incrementPhotosShared(userId);
        return photo;
    }
    async addTripPhoto(userId, dto) {
        if (!dto.image_url) {
            throw new AppError_1.ValidationError("image_url is required");
        }
        const metadata = {
            ...(dto.metadata || {}),
            location: dto.location || dto.metadata?.location || "",
        };
        const photo = await this.repository.createPhoto({
            user_id: userId,
            image_url: dto.image_url,
            caption: dto.caption || "",
            metadata,
        });
        await this.repository.incrementPhotosShared(userId);
        return photo;
    }
    async getPhotos(userId, albumId, page = 1, limit = 20) {
        const offset = (page - 1) * limit;
        const { photos, count } = await this.repository.findPhotos(userId, albumId, offset, limit);
        return {
            photos,
            pagination: {
                page,
                limit,
                total: count,
                totalPages: Math.ceil(count / limit),
            },
        };
    }
    async togglePhotoLike(photoId, userId) {
        const existingLike = await this.repository.findPhotoLike(photoId, userId);
        let liked = false;
        if (existingLike) {
            await this.repository.deletePhotoLike(photoId, userId);
            await this.repository.decrementPhotoLikes(photoId);
        }
        else {
            await this.repository.createPhotoLike(photoId, userId);
            await this.repository.incrementPhotoLikes(photoId);
            liked = true;
        }
        const photo = await this.repository.findPhotoById(photoId);
        return {
            message: liked ? "Photo liked" : "Photo unliked",
            liked,
            likesCount: photo?.likes_count || 0,
        };
    }
}
exports.AlbumsService = AlbumsService;
//# sourceMappingURL=albums.service.js.map