import { Server, Socket } from 'socket.io';
import { supabaseAdmin } from '../config/supabase';
import { logger } from '../core/logger/logger';

interface AuthenticatedSocket extends Socket {
  userId?: string;
}

export const setupChatSocket = (io: Server) => {
  // Authentication middleware
  io.use(async (socket: AuthenticatedSocket, next) => {
    try {
      const token = socket.handshake.auth.token;
      if (!token) {
        return next(new Error('Authentication error'));
      }

      // Verify token with Supabase
      const { data: { user }, error } = await supabaseAdmin.auth.getUser(token);

      if (error || !user) {
        return next(new Error('Authentication error'));
      }

      socket.userId = user.id;

      // Update user online status
      await supabaseAdmin
        .from('profiles')
        .update({
          is_online: true,
          last_seen: new Date().toISOString(),
        })
        .eq('id', user.id);

      next();
    } catch (error) {
      next(new Error('Authentication error'));
    }
  });

  io.on('connection', (socket: AuthenticatedSocket) => {
    logger.info(`User connected: ${socket.userId}`);

    // Join user's personal room
    socket.join(`user:${socket.userId}`);

    // Join chat room
    socket.on('join_room', async (roomId: string) => {
      try {
        // Verify user is participant
        const { data: membership } = await supabaseAdmin
          .from('chat_room_members')
          .select('*')
          .eq('room_id', roomId)
          .eq('user_id', socket.userId)
          .single();

        if (membership) {
          socket.join(`room:${roomId}`);
          logger.info(`User ${socket.userId} joined room ${roomId}`);
        }
      } catch (error) {
        logger.error('Error joining room:', error);
      }
    });

    // Leave chat room
    socket.on('leave_room', (roomId: string) => {
      socket.leave(`room:${roomId}`);
      logger.info(`User ${socket.userId} left room ${roomId}`);
    });

    // Send message
    socket.on('send_message', async (data: { roomId: string; text: string; type?: string }) => {
      try {
        const { roomId, text, type = 'text' } = data;

        // Verify user is participant
        const { data: membership } = await supabaseAdmin
          .from('chat_room_members')
          .select('*')
          .eq('room_id', roomId)
          .eq('user_id', socket.userId)
          .single();

        if (!membership) {
          socket.emit('error', { message: 'Room not found' });
          return;
        }

        // Create message
        const { data: message, error } = await supabaseAdmin
          .from('chat_messages')
          .insert({
            room_id: roomId,
            sender_id: socket.userId,
            text,
            type,
          })
          .select()
          .single();

        if (error) throw error;

        // Update room last message
        await supabaseAdmin
          .from('chat_rooms')
          .update({
            last_message: text,
            last_message_at: new Date().toISOString(),
          })
          .eq('id', roomId);

        // Emit to room
        io.to(`room:${roomId}`).emit('new_message', message);

        // Notify other participants
        const { data: members } = await supabaseAdmin
          .from('chat_room_members')
          .select('user_id')
          .eq('room_id', roomId)
          .neq('user_id', socket.userId);

        members?.forEach((member) => {
          io.to(`user:${member.user_id}`).emit('message_notification', {
            roomId,
            message,
          });
        });
      } catch (error) {
        logger.error('Error sending message:', error);
        socket.emit('error', { message: 'Failed to send message' });
      }
    });

    // Typing indicator
    socket.on('typing', (data: { roomId: string; isTyping: boolean }) => {
      socket.to(`room:${data.roomId}`).emit('user_typing', {
        userId: socket.userId,
        isTyping: data.isTyping,
      });
    });

    // Voice call events (placeholder)
    socket.on('call_user', (data: { roomId: string; callType: 'voice' | 'video' }) => {
      socket.to(`room:${data.roomId}`).emit('incoming_call', {
        callerId: socket.userId,
        roomId: data.roomId,
        callType: data.callType,
      });
    });

    socket.on('answer_call', (data: { roomId: string; accepted: boolean }) => {
      socket.to(`room:${data.roomId}`).emit('call_answered', {
        userId: socket.userId,
        accepted: data.accepted,
      });
    });

    socket.on('end_call', (data: { roomId: string }) => {
      socket.to(`room:${data.roomId}`).emit('call_ended', {
        userId: socket.userId,
      });
    });

    // Disconnect
    socket.on('disconnect', async () => {
      logger.info(`User disconnected: ${socket.userId}`);

      // Update user online status
      if (socket.userId) {
        await supabaseAdmin
          .from('profiles')
          .update({
            is_online: false,
            last_seen: new Date().toISOString(),
          })
          .eq('id', socket.userId);
      }
    });
  });
};
