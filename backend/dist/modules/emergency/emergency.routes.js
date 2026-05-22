"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const emergencyController = __importStar(require("./emergency.controller"));
const auth_middleware_1 = require("../../middlewares/auth.middleware");
const router = (0, express_1.Router)();
router.use(auth_middleware_1.authMiddleware);
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
exports.default = router;
//# sourceMappingURL=emergency.routes.js.map