import { AuthRepository } from './auth.repository';
import { ConflictError, UnauthorizedError } from '../../core/errors/AppError';
import { RegisterDto, LoginDto, AuthResponse, UserResponse } from './auth.types';

export class AuthService {
  private repository: AuthRepository;

  constructor() {
    this.repository = new AuthRepository();
  }

  async register(dto: RegisterDto): Promise<UserResponse> {
    try {
      const user = await this.repository.createUser(dto.email, dto.password, dto.name);

      return {
        id: user.id,
        email: user.email!,
        name: dto.name,
      };
    } catch (error: any) {
      if (error.message?.includes('already registered') || error.code === '23505') {
        throw new ConflictError('Email already registered');
      }
      throw error;
    }
  }

  async login(dto: LoginDto): Promise<AuthResponse> {
    try {
      const { session, user } = await this.repository.signIn(dto.email, dto.password);

      if (!session) {
        throw new UnauthorizedError('Invalid credentials');
      }

      // Update online status
      await this.repository.updateOnlineStatus(user.id, true);

      return {
        access_token: session.access_token,
        refresh_token: session.refresh_token,
        user: {
          id: user.id,
          email: user.email!,
          name: user.user_metadata?.full_name || user.email!,
        },
      };
    } catch (error: any) {
      throw new UnauthorizedError('Invalid email or password');
    }
  }

  async logout(userId: string): Promise<void> {
    await this.repository.updateOnlineStatus(userId, false);
  }

  async getCurrentUser(userId: string): Promise<UserResponse> {
    const profile = await this.repository.getProfile(userId);

    return {
      id: profile.id,
      email: '', // Get from auth.users if needed
      name: profile.full_name,
      avatar: profile.avatar_url,
      country: profile.country,
    };
  }

  async forgotPassword(email: string): Promise<{ message: string }> {
    try {
      await this.repository.resetPassword(email, 'https://your-app.com/reset-password');
      return { message: 'If email exists, password reset link will be sent' };
    } catch (error) {
      // Don't reveal if email exists
      return { message: 'If email exists, password reset link will be sent' };
    }
  }
}
