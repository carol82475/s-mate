"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sharePost = exports.addComment = exports.toggleLike = exports.getPostById = exports.getPosts = exports.createPost = void 0;
const forum_service_1 = require("./forum.service");
const asyncHandler_1 = require("../../utils/asyncHandler");
const response_helper_1 = require("../../core/responses/response.helper");
const forumService = new forum_service_1.ForumService();
exports.createPost = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { destination, dates, content, images } = req.body;
    const post = await forumService.createPost(userId, destination, content, images, dates);
    (0, response_helper_1.successResponse)(res, 'Post created successfully', post, 201);
});
exports.getPosts = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const { sort, page, limit } = req.query;
    const result = await forumService.getPosts(sort, parseInt(page, 10) || 1, parseInt(limit, 10) || 10);
    (0, response_helper_1.paginatedResponse)(res, 'Posts retrieved successfully', result.posts, result.pagination);
});
exports.getPostById = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const { id } = req.params;
    const post = await forumService.getPostById(id);
    (0, response_helper_1.successResponse)(res, 'Post retrieved successfully', post);
});
exports.toggleLike = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { id } = req.params;
    const result = await forumService.toggleLike(id, userId);
    (0, response_helper_1.successResponse)(res, result.message, {
        liked: result.liked,
        likesCount: result.likesCount,
    });
});
exports.addComment = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const userId = req.user.id;
    const { id } = req.params;
    const { text } = req.body;
    const comment = await forumService.addComment(id, userId, text);
    (0, response_helper_1.successResponse)(res, 'Comment added successfully', comment, 201);
});
exports.sharePost = (0, asyncHandler_1.asyncHandler)(async (req, res) => {
    const { id } = req.params;
    const result = await forumService.sharePost(id);
    (0, response_helper_1.successResponse)(res, result.message);
});
//# sourceMappingURL=forum.controller.js.map