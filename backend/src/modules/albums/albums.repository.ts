import { supabaseAdmin } from "../../config/supabase";
import { Album, Photo, PhotoLike } from "./albums.types";

export class AlbumsRepository {
  async createAlbum(albumData: {
    user_id: string;
    title: string;
    description: string;
    trip_id?: string;
  }): Promise<Album> {
    const { data, error } = await supabaseAdmin
      .from("albums")
      .insert(albumData)
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  }

  async findAlbumsByUserId(userId: string, tripId?: string): Promise<Album[]> {
    let query = supabaseAdmin
      .from("albums")
      .select("*")
      .eq("user_id", userId)
      .order("created_at", { ascending: false });

    if (tripId) {
      query = query.eq("trip_id", tripId);
    }

    const { data, error } = await query;

    if (error) throw new Error(error.message);
    return data || [];
  }

  async findAlbumById(albumId: string, userId: string): Promise<Album | null> {
    const { data, error } = await supabaseAdmin
      .from("albums")
      .select("*")
      .eq("id", albumId)
      .eq("user_id", userId)
      .single();

    if (error) return null;
    return data;
  }

  async findPhotosByAlbumId(albumId: string): Promise<Photo[]> {
    const { data, error } = await supabaseAdmin
      .from("photos")
      .select("*")
      .eq("album_id", albumId)
      .order("created_at", { ascending: false });

    if (error) throw new Error(error.message);
    return data || [];
  }

  async createPhoto(photoData: {
    user_id: string;
    album_id?: string;
    trip_id?: string;
    image_url: string;
    caption: string;
    metadata?: Record<string, unknown>;
  }): Promise<Photo> {
    const { data, error } = await supabaseAdmin
      .from("photos")
      .insert(photoData)
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  }

  async updateAlbum(albumId: string, updates: Partial<Album>): Promise<void> {
    const { error } = await supabaseAdmin
      .from("albums")
      .update(updates)
      .eq("id", albumId);

    if (error) throw new Error(error.message);
  }

  async findPhotos(
    userId: string,
    albumId: string | undefined,
    offset: number,
    limit: number,
  ): Promise<{ photos: Photo[]; count: number }> {
    let query = supabaseAdmin
      .from("photos")
      .select("*", { count: "exact" })
      .eq("user_id", userId)
      .order("created_at", { ascending: false })
      .range(offset, offset + limit - 1);

    if (albumId) {
      query = query.eq("album_id", albumId);
    }

    const { data, error, count } = await query;

    if (error) throw new Error(error.message);

    return { photos: data || [], count: count || 0 };
  }

  async findPhotoLike(
    photoId: string,
    userId: string,
  ): Promise<PhotoLike | null> {
    const { data, error } = await supabaseAdmin
      .from("photo_likes")
      .select("*")
      .eq("photo_id", photoId)
      .eq("user_id", userId)
      .single();

    if (error) return null;
    return data;
  }

  async createPhotoLike(photoId: string, userId: string): Promise<void> {
    await supabaseAdmin
      .from("photo_likes")
      .insert({ photo_id: photoId, user_id: userId });
  }

  async deletePhotoLike(photoId: string, userId: string): Promise<void> {
    await supabaseAdmin
      .from("photo_likes")
      .delete()
      .eq("photo_id", photoId)
      .eq("user_id", userId);
  }

  async incrementPhotoLikes(photoId: string): Promise<void> {
    await supabaseAdmin.rpc("increment_photo_likes", { photo_id: photoId });
  }

  async decrementPhotoLikes(photoId: string): Promise<void> {
    await supabaseAdmin.rpc("decrement_photo_likes", { photo_id: photoId });
  }

  async findPhotoById(photoId: string): Promise<Photo | null> {
    const { data, error } = await supabaseAdmin
      .from("photos")
      .select("*")
      .eq("id", photoId)
      .single();

    if (error) return null;
    return data;
  }

  async incrementPhotosShared(userId: string): Promise<void> {
    await supabaseAdmin.rpc("increment_photos_shared", { user_id: userId });
  }
}
