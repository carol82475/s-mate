import { supabaseAdmin } from '../../config/supabase';
import { ForumPost, ForumComment, ForumPostLike } from './forum.types';

export class ForumRepository {
  async createPost(postData: {
    user_id: string;
    destination: string;
    dates?: string;
    content: string;
    images: string[];
  }): Promise<ForumPost> {
    const { data, error } = await supabaseAdmin
      .from('forum_posts')
      .insert(postData)
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  }

  async findPosts(
    sort: string,
    offset: number,
    limit: number
  ): Promise<{ posts: ForumPost[]; count: number }> {
    let query = supabaseAdmin
      .from('forum_posts')
      .select('*', { count: 'exact' })
      .range(offset, offset + limit - 1);

    if (sort === 'popular') {
      query = query.order('likes_count', { ascending: false });
    } else {
      query = query.order('created_at', { ascending: false });
    }

    const { data, error, count } = await query;

    if (error) throw new Error(error.message);

    return { posts: data || [], count: count || 0 };
  }

  async findPostById(postId: string): Promise<ForumPost | null> {
    const { data, error } = await supabaseAdmin
      .from('forum_posts')
      .select('*')
      .eq('id', postId)
      .single();

    if (error) return null;
    return data;
  }

  async incrementViews(postId: string, currentViews: number): Promise<void> {
    await supabaseAdmin
      .from('forum_posts')
      .update({ views: currentViews + 1 })
      .eq('id', postId);
  }

  async findLike(postId: string, userId: string): Promise<ForumPostLike | null> {
    const { data, error } = await supabaseAdmin
      .from('forum_post_likes')
      .select('*')
      .eq('post_id', postId)
      .eq('user_id', userId)
      .single();

    if (error) return null;
    return data;
  }

  async createLike(postId: string, userId: string): Promise<void> {
    await supabaseAdmin.from('forum_post_likes').insert({ post_id: postId, user_id: userId });
  }

  async deleteLike(postId: string, userId: string): Promise<void> {
    await supabaseAdmin
      .from('forum_post_likes')
      .delete()
      .eq('post_id', postId)
      .eq('user_id', userId);
  }

  async incrementLikes(postId: string): Promise<void> {
    await supabaseAdmin.rpc('increment_likes', { post_id: postId });
  }

  async decrementLikes(postId: string): Promise<void> {
    await supabaseAdmin.rpc('decrement_likes', { post_id: postId });
  }

  async createComment(commentData: {
    post_id: string;
    user_id: string;
    content: string;
  }): Promise<ForumComment> {
    const { data, error } = await supabaseAdmin
      .from('forum_comments')
      .insert(commentData)
      .select()
      .single();

    if (error) throw new Error(error.message);
    return data;
  }

  async incrementComments(postId: string): Promise<void> {
    await supabaseAdmin.rpc('increment_comments', { post_id: postId });
  }

  async findProfileById(userId: string) {
    const { data } = await supabaseAdmin
      .from('profiles')
      .select('full_name, avatar_url')
      .eq('id', userId)
      .single();

    return data;
  }
}
