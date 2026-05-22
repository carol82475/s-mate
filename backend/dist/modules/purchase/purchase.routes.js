"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const purchase_controller_1 = require("./purchase.controller");
const auth_middleware_1 = require("../../middlewares/auth.middleware");
const router = (0, express_1.Router)();
router.get('/plans', purchase_controller_1.getPlans);
router.post('/checkout', auth_middleware_1.authMiddleware, purchase_controller_1.checkout);
exports.default = router;
//# sourceMappingURL=purchase.routes.js.map