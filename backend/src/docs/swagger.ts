import swaggerJsdoc from 'swagger-jsdoc';
import { config } from '../config/env';

const options: swaggerJsdoc.Options = {
  definition: {
    openapi: '3.0.0',
    info: {
      title: 'S-Mate API Documentation',
      version: '1.0.0',
      description: 'API documentation for S-Mate AI-powered travel companion app',
      contact: {
        name: 'S-Mate Team',
        email: 'support@smate.com',
      },
    },
    servers: [
      {
        url: `http://localhost:${config.port}/api/${config.apiVersion}`,
        description: 'Development server',
      },
      {
        url: `https://api.smate.com/api/${config.apiVersion}`,
        description: 'Production server',
      },
    ],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
        },
      },
    },
    tags: [
      { name: 'Auth', description: 'Authentication endpoints' },
      { name: 'Users', description: 'User profile and settings' },
      { name: 'Trips', description: 'Trip planning and management' },
      { name: 'Map', description: 'Map and places exploration' },
      { name: 'AI Chat', description: 'AI travel assistant' },
      { name: 'Travelers', description: 'Find and connect with travelers' },
      { name: 'Chats', description: 'Real-time messaging' },
      { name: 'Forum', description: 'Travel forum and community' },
      { name: 'Albums', description: 'Photo albums and galleries' },
      { name: 'Emergency', description: 'Emergency support and safety' },
      { name: 'Quick Actions', description: 'Dynamic quick actions' },
    ],
  },
  apis: ['./src/modules/**/*.routes.ts'],
};

export const swaggerSpec = swaggerJsdoc(options);
