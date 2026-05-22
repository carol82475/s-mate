"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.togglePhotoLike = exports.getPhotos = exports.addTripPhoto = exports.addPhotoToAlbum = exports.getAlbumById = exports.getAlbums = exports.createAlbum = void 0;
const albums_service_1 = require("./albums.service");
const asyncHandler_1 = require("../../utils/asyncHandler");
const response_helper_1 = require("../../core/responses/response.helper");
const albumsService = new albums_service_1.AlbumsService();
exports.createAlbum = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { name, description, tripId } = req.body;
    const album = await albumsService.createAlbum(userId, name, description, tripId);
    (0, response_helper_1.successResponse)(res, "Album created successfully", album, 201);
});
exports.getAlbums = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { tripId } = req.query;
    const albums = await albumsService.getAlbums(userId, tripId);
    (0, response_helper_1.successResponse)(res, "Albums retrieved successfully", albums);
});
exports.getAlbumById = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { id } = req.params;
    const album = await albumsService.getAlbumById(id, userId);
    (0, response_helper_1.successResponse)(res, "Album retrieved successfully", album);
});
exports.addPhotoToAlbum = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { id } = req.params;
    const { url, caption } = req.body;
    const photo = await albumsService.addPhotoToAlbum(id, userId, url, caption);
    (0, response_helper_1.successResponse)(res, "Photo added successfully", photo, 201);
});
exports.addTripPhoto = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { image_url, caption, location, metadata } = req.body;
    const photo = await albumsService.addTripPhoto(userId, {
        image_url,
        caption,
        location,
        metadata,
    });
    (0, response_helper_1.successResponse)(res, "Trip photo saved successfully", photo, 201);
});
exports.getPhotos = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { albumId, page, limit } = req.query;
    const result = await albumsService.getPhotos(userId, albumId, parseInt(page) || 1, parseInt(limit) || 20);
    (0, response_helper_1.paginatedResponse)(res, "Photos retrieved successfully", result.photos, result.pagination);
});
exports.togglePhotoLike = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { id } = req.params;
    const result = await albumsService.togglePhotoLike(id, userId);
    (0, response_helper_1.successResponse)(res, result.message, {
        liked: result.liked,
        likesCount: result.likesCount,
    });
});
//# sourceMappingURL=albums.controller.js.map