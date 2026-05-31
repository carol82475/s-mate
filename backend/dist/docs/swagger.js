"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.swaggerSpec = void 0;
const swagger_jsdoc_1 = __importDefault(require("swagger-jsdoc"));
const env_1 = require("../config/env");
const options = {
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
                url: `http://localhost:${env_1.config.port}/api/${env_1.config.apiVersion}`,
                description: 'Development server',
            },
            {
                url: `https://api.smate.com/api/${env_1.config.apiVersion}`,
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
            { name: 'Chats', description: 'Real-time messaging' },
            { name: 'Albums', description: 'Photo albums and galleries' },
            { name: 'Emergency', description: 'Emergency support and safety' },
            { name: 'Quick Actions', description: 'Dynamic quick actions' },
        ],
    },
    apis: ['./src/modules/**/*.routes.ts'],
};
exports.swaggerSpec = (0, swagger_jsdoc_1.default)(options);
