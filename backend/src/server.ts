import http from 'http';
import { Server } from 'socket.io';
import { createApp } from './app';
import { initializeSupabase } from './config/supabase';
import { config } from './config/env';
import { setupChatSocket } from './sockets/chat.socket';
import { logger } from './core/logger/logger';

const startServer = async () => {
  try {
    // Initialize Supabase connection
    await initializeSupabase();

    // Create Express app
    const app = createApp();

    // Create HTTP server
    const server = http.createServer(app);

    // Setup Socket.IO
    const io = new Server(server, {
      cors: {
        origin: config.socket.corsOrigin,
        credentials: true,
      },
    });

    // Setup chat socket handlers
    setupChatSocket(io);

    // Start server
    server.listen(config.port, () => {
      logger.info(' S-Mate Backend Server Started');
      logger.info(` Environment: ${config.env}`);
      logger.info(` Server: http://localhost:${config.port}`);
      logger.info(` API Docs: http://localhost:${config.port}/api-docs`);
      logger.info(` Socket.IO: Ready for connections`);
      logger.info(` Health Check: http://localhost:${config.port}/health`);
      logger.info(' Ready to accept requests!');
    });

    // Graceful shutdown
    const gracefulShutdown = async (signal: string) => {
      logger.info(`${signal} received. Starting graceful shutdown...`);

      server.close(async () => {
        logger.info('HTTP server closed');

        try {
          await io.close();
          logger.info('Socket.IO server closed');

          process.exit(0);
        } catch (error) {
          logger.error('Error during shutdown:', error);
          process.exit(1);
        }
      });

      // Force shutdown after 10 seconds
      setTimeout(() => {
        logger.error('Forced shutdown after timeout');
        process.exit(1);
      }, 10000);
    };

    process.on('SIGTERM', () => gracefulShutdown('SIGTERM'));
    process.on('SIGINT', () => gracefulShutdown('SIGINT'));
  } catch (error) {
    logger.error(' Failed to start server:', error);
    process.exit(1);
  }
};

startServer();
