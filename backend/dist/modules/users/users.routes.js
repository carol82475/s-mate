"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const users_controller_1 = require("./users.controller");
const auth_middleware_1 = require("../../middlewares/auth.middleware");
const validate_middleware_1 = require("../../middlewares/validate.middleware");
const users_validation_1 = require("./users.validation");
const router = (0, express_1.Router)();
const controller = new users_controller_1.UsersController();
router.use(auth_middleware_1.authMiddleware);
router.get('/profile', controller.getProfile);
router.put('/profile', (0, validate_middleware_1.validate)(users_validation_1.updateProfileSchema), controller.updateProfile);
router.put('/settings', (0, validate_middleware_1.validate)(users_validation_1.updateSettingsSchema), controller.updateSettings);
router.post('/change-password', (0, validate_middleware_1.validate)(users_validation_1.changePasswordSchema), controller.changePassword);
router.get('/trip-history', controller.getTripHistory);
router.get('/stats', controller.getStats);
exports.default = router;
//# sourceMappingURL=users.routes.js.map