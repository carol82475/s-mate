import { Router } from 'express';
import * as mapController from './map.controller';
import { authMiddleware } from '../../middlewares/auth.middleware';

const router = Router();

router.use(authMiddleware);

/**
 * @swagger
 * /api/v1/map/search:
 *   get:
 *     tags: [Map]
 *     summary: Search places
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: query
 *         schema:
 *           type: string
 *       - in: query
 *         name: category
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Places retrieved successfully
 */
router.get('/search', mapController.searchPlaces);

/**
 * @swagger
 * /api/v1/map/nearby:
 *   get:
 *     tags: [Map]
 *     summary: Get nearby places
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: latitude
 *         required: true
 *         schema:
 *           type: number
 *       - in: query
 *         name: longitude
 *         required: true
 *         schema:
 *           type: number
 *       - in: query
 *         name: radius
 *         schema:
 *           type: number
 *     responses:
 *       200:
 *         description: Nearby places retrieved successfully
 */
router.get('/nearby', mapController.getNearbyPlaces);

/**
 * @swagger
 * /api/v1/map/places/{id}:
 *   get:
 *     tags: [Map]
 *     summary: Get place by ID
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Place retrieved successfully
 */
router.get('/places/:id', mapController.getPlaceById);

export default router;
