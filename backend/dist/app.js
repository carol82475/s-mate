"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.createApp = void 0;
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const helmet_1 = __importDefault(require("helmet"));
const morgan_1 = __importDefault(require("morgan"));
const swagger_ui_express_1 = __importDefault(require("swagger-ui-express"));
const env_1 = require("./config/env");
const swagger_1 = require("./docs/swagger");
const error_middleware_1 = require("./middlewares/error.middleware");
const rateLimit_middleware_1 = require("./middlewares/rateLimit.middleware");
// Import routes
const auth_routes_1 = __importDefault(require("./modules/auth/auth.routes"));
const users_routes_1 = __importDefault(require("./modules/users/users.routes"));
const trips_routes_1 = __importDefault(require("./modules/trips/trips.routes"));
const map_routes_1 = __importDefault(require("./modules/map/map.routes"));
const ai_chat_routes_1 = __importDefault(require("./modules/ai-chat/ai-chat.routes"));
const travelers_routes_1 = __importDefault(require("./modules/travelers/travelers.routes"));
const chats_routes_1 = __importDefault(require("./modules/chats/chats.routes"));
const forum_routes_1 = __importDefault(require("./modules/forum/forum.routes"));
const albums_routes_1 = __importDefault(require("./modules/albums/albums.routes"));
const emergency_routes_1 = __importDefault(require("./modules/emergency/emergency.routes"));
const quick_actions_routes_1 = __importDefault(require("./modules/quick-actions/quick-actions.routes"));
const purchase_routes_1 = __importDefault(require("./modules/purchase/purchase.routes"));
const createApp = () => {
    const app = (0, express_1.default)();
    // Security middleware
    app.use((0, helmet_1.default)());
    app.use((0, cors_1.default)({
        origin: env_1.config.cors.origin,
        credentials: true,
    }));
    // Rate limiting
    app.use('/api', rateLimit_middleware_1.apiLimiter);
    // Body parsing middleware
    app.use(express_1.default.json({ limit: '10mb' }));
    app.use(express_1.default.urlencoded({ extended: true, limit: '10mb' }));
    // Logging middleware
    if (env_1.config.env === 'development') {
        app.use((0, morgan_1.default)('dev'));
    }
    else {
        app.use((0, morgan_1.default)('combined'));
    }
    // Health check endpoint
    app.get('/health', (_req, res) => {
        res.status(200).json({
            success: true,
            message: 'Server is healthy',
            timestamp: new Date().toISOString(),
            environment: env_1.config.env,
        });
    });
    // API documentation
    app.use('/api-docs', swagger_ui_express_1.default.serve, swagger_ui_express_1.default.setup(swagger_1.swaggerSpec));
    // API routes
    const apiPrefix = `/api/${env_1.config.apiVersion}`;
    app.use(`${apiPrefix}/auth`, auth_routes_1.default);
    app.use(`${apiPrefix}/users`, users_routes_1.default);
    app.use(`${apiPrefix}/trips`, trips_routes_1.default);
    app.use(`${apiPrefix}/map`, map_routes_1.default);
    app.use(`${apiPrefix}/ai-chat`, ai_chat_routes_1.default);
    app.use(`${apiPrefix}/travelers`, travelers_routes_1.default);
    app.use(`${apiPrefix}/chats`, chats_routes_1.default);
    app.use(`${apiPrefix}/forum`, forum_routes_1.default);
    app.use(`${apiPrefix}/albums`, albums_routes_1.default);
    app.use(`${apiPrefix}/emergency`, emergency_routes_1.default);
    app.use(`${apiPrefix}/quick-actions`, quick_actions_routes_1.default);
    app.use(`${apiPrefix}/purchase`, purchase_routes_1.default);
    // 404 handler
    app.use(error_middleware_1.notFoundHandler);
    // Error handler
    app.use(error_middleware_1.errorHandler);
    return app;
};
exports.createApp = createApp;
//# sourceMappingURL=app.js.map