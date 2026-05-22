import mongoose, { Document } from 'mongoose';
export interface ICheckpoint {
    time: string;
    title: string;
    description: string;
    completed: boolean;
}
export interface IItineraryDay {
    day: number;
    title: string;
    checkpoints: ICheckpoint[];
}
export interface ITrip extends Document {
    userId: mongoose.Types.ObjectId;
    destination: string;
    startDate: Date;
    endDate: Date;
    budget: number;
    travelerCount: number;
    preferences: string[];
    itinerary: IItineraryDay[];
    status: 'planning' | 'active' | 'completed' | 'cancelled';
    progress: number;
    createdAt: Date;
    updatedAt: Date;
}
export declare const Trip: any;
//# sourceMappingURL=Trip.d.ts.map