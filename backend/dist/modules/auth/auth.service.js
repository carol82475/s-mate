"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthService = void 0;
const auth_repository_1 = require("./auth.repository");
const AppError_1 = require("../../core/errors/AppError");
class AuthService {
    constructor() {
        this.repository = new auth_repository_1.AuthRepository();
    }
    async register(dto) {
        try {
            const user = await this.repository.createUser(dto.email, dto.password, dto.name);
            return {
                id: user.id,
                email: user.email,
                name: dto.name,
            };
        }
        catch (error) {
            if (error.message?.includes('already registered') || error.code === '23505') {
                throw new AppError_1.ConflictError('Email already registered');
            }
            throw error;
        }
    }
    async login(dto) {
        try {
            const { session, user } = await this.repository.signIn(dto.email, dto.password);
            if (!session) {
                throw new AppError_1.UnauthorizedError('Invalid credentials');
            }
            // Update online status
            await this.repository.updateOnlineStatus(user.id, true);
            return {
                access_token: session.access_token,
                refresh_token: session.refresh_token,
                user: {
                    id: user.id,
                    email: user.email,
                    name: user.user_metadata?.full_name || user.email,
                },
            };
        }
        catch (error) {
            throw new AppError_1.UnauthorizedError('Invalid email or password');
        }
    }
    async logout(userId) {
        await this.repository.updateOnlineStatus(userId, false);
    }
    async getCurrentUser(userId) {
        const profile = await this.repository.getProfile(userId);
        return {
            id: profile.id,
            email: '', // Get from auth.users if needed
            name: profile.full_name,
            avatar: profile.avatar_url,
            country: profile.country,
        };
    }
    async forgotPassword(email) {
        try {
            await this.repository.resetPassword(email, 'https://your-app.com/reset-password');
            return { message: 'If email exists, password reset link will be sent' };
        }
        catch (error) {
            // Don't reveal if email exists
            return { message: 'If email exists, password reset link will be sent' };
        }
    }
}
exports.AuthService = AuthService;
//# sourceMappingURL=auth.service.js.map