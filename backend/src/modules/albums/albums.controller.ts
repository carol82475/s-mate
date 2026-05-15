import { Response } from "express";
import { AuthRequest } from "../../middlewares/auth.middleware";
import { AlbumsService } from "./albums.service";
import { asyncHandler } from "../../utils/asyncHandler";
import {
  successResponse,
  paginatedResponse,
} from "../../core/responses/response.helper";

const albumsService = new AlbumsService();

export const createAlbum = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { name, description, tripId } = req.body;
    const album = await albumsService.createAlbum(
      userId,
      name,
      description,
      tripId,
    );
    successResponse(res, "Album created successfully", album, 201);
  },
);

export const getAlbums = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { tripId } = req.query;
    const albums = await albumsService.getAlbums(userId, tripId as string);
    successResponse(res, "Albums retrieved successfully", albums);
  },
);

export const getAlbumById = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { id } = req.params;
    const album = await albumsService.getAlbumById(id, userId);
    successResponse(res, "Album retrieved successfully", album);
  },
);

export const addPhotoToAlbum = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { id } = req.params;
    const { url, caption } = req.body;
    const photo = await albumsService.addPhotoToAlbum(id, userId, url, caption);
    successResponse(res, "Photo added successfully", photo, 201);
  },
);

export const addTripPhoto = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { image_url, caption, location, metadata } = req.body;
    const photo = await albumsService.addTripPhoto(userId, {
      image_url,
      caption,
      location,
      metadata,
    });

    successResponse(res, "Trip photo saved successfully", photo, 201);
  },
);

export const getPhotos = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { albumId, page, limit } = req.query;
    const result = await albumsService.getPhotos(
      userId,
      albumId as string,
      parseInt(page as string) || 1,
      parseInt(limit as string) || 20,
    );
    paginatedResponse(
      res,
      "Photos retrieved successfully",
      result.photos,
      result.pagination,
    );
  },
);

export const togglePhotoLike = asyncHandler(
  async (req: AuthRequest, res: Response) => {
    const userId = req.user!.id;
    const { id } = req.params;
    const result = await albumsService.togglePhotoLike(id, userId);
    successResponse(res, result.message, {
      liked: result.liked,
      likesCount: result.likesCount,
    });
  },
);
