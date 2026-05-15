import { NotFoundError } from '../../core/errors/AppError';
import { ChatsRepository } from './chats.repository';

export class ChatsService {
  private repository: ChatsRepository;

  constructor() {
    this.repository = new ChatsRepository();
  }

  async getChatRooms(userId: string) {
    return await this.repository.findRoomsByUserId(userId);
  }

  async getChatRoom(roomId: string, userId: string) {
    // Verify user is member
    const membership = await this.repository.findMembership(roomId, userId);

    if (!membership) throw new NotFoundError('Chat room not found');

    const room = await this.repository.findRoomById(roomId);

    if (!room) throw new NotFoundError('Chat room not found');

    return room;
  }

  async getOrCreateChatRoom(userId: string, otherUserId: string) {
    // Check if room exists
    const userRooms = await this.repository.findRoomsByMember(userId);

    for (const roomId of userRooms) {
      const otherMember = await this.repository.findOtherMember(roomId, userId);

      if (otherMember && otherMember.user_id === otherUserId) {
        const room = await this.repository.findRoomById(roomId);
        return room;
      }
    }

    // Create new room
    const newRoom = await this.repository.createRoom();

    // Add members
    await this.repository.addMembers(newRoom.id, [userId, otherUserId]);

    return newRoom;
  }

  async getChatMessages(roomId: string, userId: string, page = 1, limit = 50) {
    // Verify user is member
    const membership = await this.repository.findMembership(roomId, userId);

    if (!membership) throw new NotFoundError('Chat room not found');

    const offset = (page - 1) * limit;

    const { messages, count } = await this.repository.findMessages(roomId, offset, limit);

    return {
      messages: messages.reverse(),
      pagination: {
        page,
        limit,
        total: count,
        totalPages: Math.ceil(count / limit),
      },
    };
  }

  async sendMessage(roomId: string, userId: string, text: string, type = 'text') {
    // Verify user is member
    const membership = await this.repository.findMembership(roomId, userId);

    if (!membership) throw new NotFoundError('Chat room not found');

    const message = await this.repository.createMessage({
      room_id: roomId,
      sender_id: userId,
      text,
      type,
    });

    // Update room last message
    await this.repository.updateRoomLastMessage(roomId, text, new Date().toISOString());

    return message;
  }

  async markMessagesAsRead(roomId: string, userId: string) {
    await this.repository.markMessagesAsRead(roomId, userId);

    return { message: 'Messages marked as read' };
  }
}
