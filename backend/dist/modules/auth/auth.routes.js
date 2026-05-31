"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const auth_controller_1 = require("./auth.controller");
const validate_middleware_1 = require("../../middlewares/validate.middleware");
const auth_middleware_1 = require("../../middlewares/auth.middleware");
const rateLimit_middleware_1 = require("../../middlewares/rateLimit.middleware");
const auth_validation_1 = require("./auth.validation");
const router = (0, express_1.Router)();
const controller = new auth_controller_1.AuthController();
router.post('/register', rateLimit_middleware_1.authLimiter, (0, validate_middleware_1.validate)(auth_validation_1.registerSchema), controller.register);
router.post('/login', rateLimit_middleware_1.authLimiter, (0, validate_middleware_1.validate)(auth_validation_1.loginSchema), controller.login);
router.post('/logout', auth_middleware_1.authMiddleware, controller.logout);
router.get('/me', auth_middleware_1.authMiddleware, controller.getCurrentUser);
router.post('/forgot-password', (0, validate_middleware_1.validate)(auth_validation_1.forgotPasswordSchema), controller.forgotPassword);
exports.default = router;
//# sourceMappingURL=auth.routes.js.map