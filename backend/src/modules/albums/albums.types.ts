export interface Album {
  id: string;
  user_id: string;
  trip_id?: string;
  title: string;
  description: string;
  cover_photo_url?: string;
  photo_count: number;
  created_at: string;
  updated_at: string;
}

export interface Photo {
  id: string;
  user_id: string;
  album_id?: string;
  trip_id?: string;
  image_url: string;
  caption: string;
  likes_count: number;
  metadata?: Record<string, unknown>;
  created_at: string;
  updated_at: string;
}

export interface PhotoLike {
  id: string;
  photo_id: string;
  user_id: string;
  created_at: string;
}

export interface CreateAlbumDTO {
  name: string;
  description?: string;
  tripId?: string;
}

export interface AddPhotoDTO {
  url: string;
  caption?: string;
}

export interface AddTripPhotoDTO {
  image_url: string;
  caption?: string;
  location?: string;
  metadata?: Record<string, unknown>;
}
