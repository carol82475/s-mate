export interface RegisterDto {
    name: string;
    email: string;
    password: string;
}
export interface LoginDto {
    email: string;
    password: string;
}
export interface AuthResponse {
    access_token: string;
    refresh_token: string;
    user: {
        id: string;
        email: string;
        name: string;
    };
}
export interface UserResponse {
    id: string;
    email: string;
    name: string;
    avatar?: string;
    country?: string;
}
//# sourceMappingURL=auth.types.d.ts.map