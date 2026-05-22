"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ForumRepository = void 0;
const supabase_1 = require("../../config/supabase");
class ForumRepository {
    async createPost(postData) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('forum_posts')
            .insert(postData)
            .select()
            .single();
        if (error)
            throw new Error(error.message);
        return data;
    }
    async findPosts(sort, offset, limit) {
        let query = supabase_1.supabaseAdmin
            .from('forum_posts')
            .select('*', { count: 'exact' })
            .range(offset, offset + limit - 1);
        if (sort === 'popular') {
            query = query.order('likes_count', { ascending: false });
        }
        else {
            query = query.order('created_at', { ascending: false });
        }
        const { data, error, count } = await query;
        if (error)
            throw new Error(error.message);
        return { posts: data || [], count: count || 0 };
    }
    async findPostById(postId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('forum_posts')
            .select('*')
            .eq('id', postId)
            .single();
        if (error)
            return null;
        return data;
    }
    async incrementViews(postId, currentViews) {
        await supabase_1.supabaseAdmin
            .from('forum_posts')
            .update({ views: currentViews + 1 })
            .eq('id', postId);
    }
    async findLike(postId, userId) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('forum_post_likes')
            .select('*')
            .eq('post_id', postId)
            .eq('user_id', userId)
            .single();
        if (error)
            return null;
        return data;
    }
    async createLike(postId, userId) {
        await supabase_1.supabaseAdmin.from('forum_post_likes').insert({ post_id: postId, user_id: userId });
    }
    async deleteLike(postId, userId) {
        await supabase_1.supabaseAdmin
            .from('forum_post_likes')
            .delete()
            .eq('post_id', postId)
            .eq('user_id', userId);
    }
    async incrementLikes(postId) {
        await supabase_1.supabaseAdmin.rpc('increment_likes', { post_id: postId });
    }
    async decrementLikes(postId) {
        await supabase_1.supabaseAdmin.rpc('decrement_likes', { post_id: postId });
    }
    async createComment(commentData) {
        const { data, error } = await supabase_1.supabaseAdmin
            .from('forum_comments')
            .insert(commentData)
            .select()
            .single();
        if (error)
            throw new Error(error.message);
        return data;
    }
    async incrementComments(postId) {
        await supabase_1.supabaseAdmin.rpc('increment_comments', { post_id: postId });
    }
    async findProfileById(userId) {
        const { data } = await supabase_1.supabaseAdmin
            .from('profiles')
            .select('full_name, avatar_url')
            .eq('id', userId)
            .single();
        return data;
    }
}
exports.ForumRepository = ForumRepository;
//# sourceMappingURL=forum.repository.js.map