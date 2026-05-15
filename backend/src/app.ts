import express, { Application } from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import swaggerUi from 'swagger-ui-express';
import { config } from './config/env';
import { swaggerSpec } from './docs/swagger';
import { errorHandler, notFoundHandler } from './middlewares/error.middleware';
import { apiLimiter } from './middlewares/rateLimit.middleware';

// Import routes
import authRoutes from './modules/auth/auth.routes';
import usersRoutes from './modules/users/users.routes';
import tripsRoutes from './modules/trips/trips.routes';
import mapRoutes from './modules/map/map.routes';
import aiChatRoutes from './modules/ai-chat/ai-chat.routes';
import travelersRoutes from './modules/travelers/travelers.routes';
import chatsRoutes from './modules/chats/chats.routes';
import forumRoutes from './modules/forum/forum.routes';
import albumsRoutes from './modules/albums/albums.routes';
import emergencyRoutes from './modules/emergency/emergency.routes';
import quickActionsRoutes from './modules/quick-actions/quick-actions.routes';
import purchaseRoutes from './modules/purchase/purchase.routes';

export const createApp = (): Application => {
  const app = express();

  // Security middleware
  app.use(helmet());
  app.use(
    cors({
      origin: config.cors.origin,
      credentials: true,
    })
  );

  // Rate limiting
  app.use('/api', apiLimiter);

  // Body parsing middleware
  app.use(express.json({ limit: '10mb' }));
  app.use(express.urlencoded({ extended: true, limit: '10mb' }));

  // Logging middleware
  if (config.env === 'development') {
    app.use(morgan('dev'));
  } else {
    app.use(morgan('combined'));
  }

  // Health check endpoint
  app.get('/health', (_req, res) => {
    res.status(200).json({
      success: true,
      message: 'Server is healthy',
      timestamp: new Date().toISOString(),
      environment: config.env,
    });
  });

  // API documentation
  app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

  // API routes
  const apiPrefix = `/api/${config.apiVersion}`;
  app.use(`${apiPrefix}/auth`, authRoutes);
  app.use(`${apiPrefix}/users`, usersRoutes);
  app.use(`${apiPrefix}/trips`, tripsRoutes);
  app.use(`${apiPrefix}/map`, mapRoutes);
  app.use(`${apiPrefix}/ai-chat`, aiChatRoutes);
  app.use(`${apiPrefix}/travelers`, travelersRoutes);
  app.use(`${apiPrefix}/chats`, chatsRoutes);
  app.use(`${apiPrefix}/forum`, forumRoutes);
  app.use(`${apiPrefix}/albums`, albumsRoutes);
  app.use(`${apiPrefix}/emergency`, emergencyRoutes);
  app.use(`${apiPrefix}/quick-actions`, quickActionsRoutes);
  app.use(`${apiPrefix}/purchase`, purchaseRoutes);
  // 404 handler
  app.use(notFoundHandler);

  // Error handler
  app.use(errorHandler);

  return app;
};
