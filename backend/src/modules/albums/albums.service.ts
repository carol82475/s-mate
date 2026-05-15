import { NotFoundError, ValidationError } from "../../core/errors/AppError";
import { AlbumsRepository } from "./albums.repository";
import { AddTripPhotoDTO } from "./albums.types";

export class AlbumsService {
  private repository: AlbumsRepository;

  constructor() {
    this.repository = new AlbumsRepository();
  }

  async createAlbum(
    userId: string,
    name: string,
    description?: string,
    tripId?: string,
  ) {
    return await this.repository.createAlbum({
      user_id: userId,
      title: name,
      description: description || "",
      trip_id: tripId || undefined,
    });
  }

  async getAlbums(userId: string, tripId?: string) {
    return await this.repository.findAlbumsByUserId(userId, tripId);
  }

  async getAlbumById(albumId: string, userId: string) {
    const album = await this.repository.findAlbumById(albumId, userId);

    if (!album) throw new NotFoundError("Album not found");

    const photos = await this.repository.findPhotosByAlbumId(albumId);

    return {
      ...album,
      photos,
    };
  }

  async addPhotoToAlbum(
    albumId: string,
    userId: string,
    url: string,
    caption?: string,
  ) {
    const album = await this.repository.findAlbumById(albumId, userId);

    if (!album) throw new NotFoundError("Album not found");

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

  async addTripPhoto(userId: string, dto: AddTripPhotoDTO) {
    if (!dto.image_url) {
      throw new ValidationError("image_url is required");
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

  async getPhotos(userId: string, albumId?: string, page = 1, limit = 20) {
    const offset = (page - 1) * limit;

    const { photos, count } = await this.repository.findPhotos(
      userId,
      albumId,
      offset,
      limit,
    );

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

  async togglePhotoLike(photoId: string, userId: string) {
    const existingLike = await this.repository.findPhotoLike(photoId, userId);

    let liked = false;

    if (existingLike) {
      await this.repository.deletePhotoLike(photoId, userId);
      await this.repository.decrementPhotoLikes(photoId);
    } else {
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
