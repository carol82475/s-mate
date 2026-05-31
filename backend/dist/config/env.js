"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.config = void 0;
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
exports.config = {
    env: process.env.NODE_ENV || 'development',
    port: parseInt(process.env.PORT || '5000', 10),
    apiVersion: process.env.API_VERSION || 'v1',
    supabase: {
        url: process.env.SUPABASE_URL || '',
        anonKey: process.env.SUPABASE_ANON_KEY || '',
        serviceRoleKey: process.env.SUPABASE_SERVICE_ROLE_KEY || '',
    },
    cors: {
        origin: process.env.CORS_ORIGIN?.split(',') || [
            'http://localhost:3000',
            'http://10.0.2.2:5000',
        ],
    },
    rateLimit: {
        windowMs: parseInt(process.env.RATE_LIMIT_WINDOW_MS || '900000', 10),
        max: parseInt(process.env.RATE_LIMIT_MAX_REQUESTS || '100', 10),
    },
    ai: {
        openaiKey: process.env.OPENAI_API_KEY,
        geminiKey: process.env.GEMINI_API_KEY,
    },
    socket: {
        corsOrigin: process.env.SOCKET_CORS_ORIGIN ||
            'http://localhost:3000',
    },
    logging: {
        level: process.env.LOG_LEVEL || 'info',
    },
};
// Validate required environment variables
const requiredEnvVars = [
    'SUPABASE_URL',
    'SUPABASE_ANON_KEY',
    'SUPABASE_SERVICE_ROLE_KEY',
];
const missingVars = requiredEnvVars.filter((key) => !process.env[key]);
if (missingVars.length > 0) {
    console.error(' Missing environment variables:', missingVars.join(', '));
    process.exit(1);
}
//# sourceMappingURL=env.js.map