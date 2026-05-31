"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const http_1 = __importDefault(require("http"));
const socket_io_1 = require("socket.io");
const app_1 = require("./app");
const supabase_1 = require("./config/supabase");
const env_1 = require("./config/env");
const chat_socket_1 = require("./sockets/chat.socket");
const logger_1 = require("./core/logger/logger");
const startServer = async () => {
    try {
        // Initialize Supabase connection
        await (0, supabase_1.initializeSupabase)();
        // Create Express app
        const app = (0, app_1.createApp)();
        // Create HTTP server
        const server = http_1.default.createServer(app);
        // Setup Socket.IO
        const io = new socket_io_1.Server(server, {
            cors: {
                origin: env_1.config.socket.corsOrigin,
                credentials: true,
            },
        });
        // Setup chat socket handlers
        (0, chat_socket_1.setupChatSocket)(io);
        // Start server
        server.listen(env_1.config.port, () => {
            logger_1.logger.info(' S-Mate Backend Server Started');
            logger_1.logger.info(` Environment: ${env_1.config.env}`);
            logger_1.logger.info(` Server: http://localhost:${env_1.config.port}`);
            logger_1.logger.info(` API Docs: http://localhost:${env_1.config.port}/api-docs`);
            logger_1.logger.info(` Socket.IO: Ready for connections`);
            logger_1.logger.info(` Health Check: http://localhost:${env_1.config.port}/health`);
            logger_1.logger.info(' Ready to accept requests!');
        });
        // Graceful shutdown
        const gracefulShutdown = async (signal) => {
            logger_1.logger.info(`${signal} received. Starting graceful shutdown...`);
            server.close(async () => {
                logger_1.logger.info('HTTP server closed');
                try {
                    await io.close();
                    logger_1.logger.info('Socket.IO server closed');
                    process.exit(0);
                }
                catch (error) {
                    logger_1.logger.error('Error during shutdown:', error);
                    process.exit(1);
                }
            });
            // Force shutdown after 10 seconds
            setTimeout(() => {
                logger_1.logger.error('Forced shutdown after timeout');
                process.exit(1);
            }, 10000);
        };
        process.on('SIGTERM', () => gracefulShutdown('SIGTERM'));
        process.on('SIGINT', () => gracefulShutdown('SIGINT'));
    }
    catch (error) {
        logger_1.logger.error(' Failed to start server:', error);
        process.exit(1);
    }
};
startServer();
//# sourceMappingURL=server.js.map