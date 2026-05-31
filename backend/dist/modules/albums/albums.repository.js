"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AlbumsRepository = void 0;
const supabase_1 = require("../../config/supabase");
class AlbumsRepository {
    async createAlbum(albumData) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from("albums")
            .insert(albumData)
            .select()
            .single();
        if (error)
            throw new Error(error.message);
        return data;
    }
    async findAlbumsByUserId(userId, tripId) {
        let query = supabase_1.supabaseAdmin
            .from("albums")
            .select("*")
            .eq("user_id", userId)
            .order("created_at", { ascending: false });
        if (tripId) {
            query = query.eq("trip_id", tripId);
        }
        const { data, error } = await query;
        if (error)
            throw new Error(error.message);
        return data || [];
    }
    async findAlbumById(albumId, userId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from("albums")
            .select("*")
            .eq("id", albumId)
            .eq("user_id", userId)
            .single();
        if (error)
            return null;
        return data;
    }
    async findPhotosByAlbumId(albumId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from("photos")
            .select("*")
            .eq("album_id", albumId)
            .order("created_at", { ascending: false });
        if (error)
            throw new Error(error.message);
        return data || [];
    }
    async createPhoto(photoData) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from("photos")
            .insert(photoData)
            .select()
            .single();
        if (error)
            throw new Error(error.message);
        return data;
    }
    async updateAlbum(albumId, updates) {
        const { error } = await supabase_1.supabaseAdmin
            .from("albums")
            .update(updates)
            .eq("id", albumId);
        if (error)
            throw new Error(error.message);
    }
    async findPhotos(userId, albumId, offset, limit) {
        let query = supabase_1.supabaseAdmin
            .from("photos")
            .select("*", { count: "exact" })
            .eq("user_id", userId)
            .order("created_at", { ascending: false })
            .range(offset, offset + limit - 1);
        if (albumId) {
            query = query.eq("album_id", albumId);
        }
        const { data, error, count } = await query;
        if (error)
            throw new Error(error.message);
        return { photos: data || [], count: count || 0 };
    }
    async findPhotoLike(photoId, userId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from("photo_likes")
            .select("*")
            .eq("photo_id", photoId)
            .eq("user_id", userId)
            .single();
        if (error)
            return null;
        return data;
    }
    async createPhotoLike(photoId, userId) {
        await supabase_1.supabaseAdmin
            .from("photo_likes")
            .insert({ photo_id: photoId, user_id: userId });
    }
    async deletePhotoLike(photoId, userId) {
        await supabase_1.supabaseAdmin
            .from("photo_likes")
            .delete()
            .eq("photo_id", photoId)
            .eq("user_id", userId);
    }
    async incrementPhotoLikes(photoId) {
        await supabase_1.supabaseAdmin.rpc("increment_photo_likes", { photo_id: photoId });
    }
    async decrementPhotoLikes(photoId) {
        await supabase_1.supabaseAdmin.rpc("decrement_photo_likes", { photo_id: photoId });
    }
    async findPhotoById(photoId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from("photos")
            .select("*")
            .eq("id", photoId)
            .single();
        if (error)
            return null;
        return data;
    }
    async incrementPhotosShared(userId) {
        await supabase_1.supabaseAdmin.rpc("increment_photos_shared", { user_id: userId });
    }
}
exports.AlbumsRepository = AlbumsRepository;
//# sourceMappingURL=albums.repository.js.map