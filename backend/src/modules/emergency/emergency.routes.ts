import { Router } from 'express';
import * as emergencyController from './emergency.controller';
import { authMiddleware } from '../../middlewares/auth.middleware';

const router = Router();

router.use(authMiddleware);

/**
 * @swagger
 * /api/v1/emergency/contacts:
 *   get:
 *     tags: [Emergency]
 *     summary: Get emergency contact numbers
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Emergency contacts retrieved successfully
 */
router.get('/contacts', emergencyController.getEmergencyContacts);

/**
 * @swagger
 * /api/v1/emergency/phrases:
 *   get:
 *     tags: [Emergency]
 *     summary: Get quick phrases in local language
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: language
 *         schema:
 *           type: string
 *           enum: [vi, en]
 *     responses:
 *       200:
 *         description: Quick phrases retrieved successfully
 */
router.get('/phrases', emergencyController.getQuickPhrases);

/**
 * @swagger
 * /api/v1/emergency/safety-tips:
 *   get:
 *     tags: [Emergency]
 *     summary: Get safety tips for travelers
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Safety tips retrieved successfully
 */
router.get('/safety-tips', emergencyController.getSafetyTips);

/**
 * @swagger
 * /api/v1/emergency/call:
 *   post:
 *     tags: [Emergency]
 *     summary: Initiate emergency call (placeholder)
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - type
 *             properties:
 *               type:
 *                 type: string
 *                 enum: [police, ambulance, fire]
 *               location:
 *                 type: string
 *     responses:
 *       200:
 *         description: Emergency call initiated
 */
router.post('/call', emergencyController.makeEmergencyCall);

export default router;
