import { RegisterDto, LoginDto, AuthResponse, UserResponse } from './auth.types';
export declare class AuthService {
    private repository;
    constructor();
    register(dto: RegisterDto): Promise<UserResponse>;
    login(dto: LoginDto): Promise<AuthResponse>;
    logout(userId: string): Promise<void>;
    getCurrentUser(userId: string): Promise<UserResponse>;
    forgotPassword(email: string): Promise<{
        message: string;
    }>;
}
//# sourceMappingURL=auth.service.d.ts.map