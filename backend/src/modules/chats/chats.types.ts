export interface ChatRoom {
  id: string;
  last_message?: string;
  last_message_at?: string;
  created_at: string;
  updated_at: string;
}

export interface ChatMessage {
  id: string;
  room_id: string;
  sender_id: string;
  text: string;
  type: 'text' | 'image' | 'location';
  read_by: string[];
  created_at: string;
  updated_at: string;
}

export interface ChatRoomMember {
  id: string;
  room_id: string;
  user_id: string;
  created_at: string;
}

export interface SendMessageDTO {
  text: string;
  type?: 'text' | 'image' | 'location';
}

export interface CreateChatRoomDTO {
  otherUserId: string;
}
