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
exports.Trip = void 0;
const mongoose_1 = __importStar(require("mongoose"));
const checkpointSchema = new mongoose_1.Schema({
    time: { type: String, required: true },
    title: { type: String, required: true },
    description: { type: String, required: true },
    completed: { type: Boolean, default: false },
}, { _id: false });
const itineraryDaySchema = new mongoose_1.Schema({
    day: { type: Number, required: true },
    title: { type: String, required: true },
    checkpoints: [checkpointSchema],
}, { _id: false });
const tripSchema = new mongoose_1.Schema({
    userId: {
        type: mongoose_1.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },
    destination: {
        type: String,
        required: true,
    },
    startDate: {
        type: Date,
        required: true,
    },
    endDate: {
        type: Date,
        required: true,
    },
    budget: {
        type: Number,
        required: true,
    },
    travelerCount: {
        type: Number,
        required: true,
        min: 1,
    },
    preferences: {
        type: [String],
        default: [],
    },
    itinerary: [itineraryDaySchema],
    status: {
        type: String,
        enum: ['planning', 'active', 'completed', 'cancelled'],
        default: 'planning',
    },
    progress: {
        type: Number,
        default: 0,
        min: 0,
        max: 100,
    },
}, {
    timestamps: true,
});
tripSchema.index({ userId: 1, status: 1 });
tripSchema.index({ destination: 'text' });
exports.Trip = mongoose_1.default.model('Trip', tripSchema);
//# sourceMappingURL=Trip.js.map