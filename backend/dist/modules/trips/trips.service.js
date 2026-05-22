"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TripsService = void 0;
const AppError_1 = require("../../core/errors/AppError");
const trips_repository_1 = require("./trips.repository");
class TripsService {
    constructor() {
        this.repository = new trips_repository_1.TripsRepository();
    }
    async getDestinations() {
        return [
            'Hanoi',
            'Ho Chi Minh City',
            'Da Nang',
            'Hoi An',
            'Nha Trang',
            'Da Lat',
            'Phu Quoc',
            'Sapa',
        ];
    }
    async createTrip(userId, tripData) {
        const { destination, start_date, end_date, budget, travelers, preferences, } = tripData;
        const itinerary = this.generateMockItinerary(destination, start_date, end_date, preferences || []);
        const trip = await this.repository.createTrip({
            user_id: userId,
            destination,
            start_date,
            end_date,
            budget,
            traveler_count: travelers,
            preferences: preferences || [],
            status: 'planning',
            progress: 0,
        });
        for (const day of itinerary) {
            const dayData = await this.repository.createItineraryDay({
                trip_id: trip.id,
                day_number: day.day_number,
                title: day.title,
                date: day.date,
            });
            const checkpoints = day.checkpoints.map((cp) => ({
                itinerary_day_id: dayData.id,
                time: cp.time,
                title: cp.title,
                description: cp.description,
                completed: cp.completed,
                sort_order: cp.sort_order,
            }));
            await this.repository.createCheckpoints(checkpoints);
        }
        return await this.repository.findByIdAndUserId(trip.id, userId);
    }
    async getTrips(userId, status, page = 1, limit = 10) {
        const offset = (page - 1) * limit;
        const { trips, count } = await this.repository.findByUserId(userId, status, offset, limit);
        return {
            trips,
            pagination: {
                page,
                limit,
                total: count,
                totalPages: Math.ceil(count / limit),
            },
        };
    }
    async getTripById(tripId, userId) {
        const trip = await this.repository.findByIdAndUserId(tripId, userId);
        if (!trip) {
            throw new AppError_1.NotFoundError('Trip not found');
        }
        return trip;
    }
    async updateTrip(tripId, userId, updates) {
        const trip = await this.repository.updateTrip(tripId, userId, updates);
        if (!trip) {
            throw new AppError_1.NotFoundError('Trip not found');
        }
        return trip;
    }
    async deleteTrip(tripId, userId) {
        const deleted = await this.repository.deleteTrip(tripId, userId);
        if (!deleted) {
            throw new AppError_1.NotFoundError('Trip not found');
        }
        return {
            message: 'Trip deleted successfully',
        };
    }
    async updateCheckpoint(tripId, userId, day, checkpointIndex, completed) {
        const trip = await this.repository.findByIdAndUserId(tripId, userId);
        if (!trip) {
            throw new AppError_1.NotFoundError('Trip not found');
        }
        const dayData = trip.itinerary_days.find((d) => d.day_number === day);
        if (!dayData) {
            throw new AppError_1.NotFoundError('Day not found');
        }
        const checkpoint = dayData.checkpoints.find((c) => c.sort_order === checkpointIndex);
        if (!checkpoint) {
            throw new AppError_1.NotFoundError('Checkpoint not found');
        }
        await this.repository.updateCheckpoint(checkpoint.id, completed);
        const dayIds = trip.itinerary_days.map((d) => d.id);
        const allCheckpoints = await this.repository.findCheckpointsByDayIds(dayIds);
        const totalCheckpoints = allCheckpoints.length;
        const completedCheckpoints = allCheckpoints.filter((c) => c.completed).length;
        const progress = totalCheckpoints > 0
            ? Math.round((completedCheckpoints /
                totalCheckpoints) *
                100)
            : 0;
        await this.repository.updateTrip(tripId, userId, {
            progress,
            status: progress === 100
                ? 'completed'
                : trip.status,
        });
        return {
            progress,
            completed,
        };
    }
    generateMockItinerary(destination, startDate, endDate, _preferences) {
        const start = new Date(startDate);
        const end = new Date(endDate);
        const days = Math.ceil((end.getTime() -
            start.getTime()) /
            (1000 * 60 * 60 * 24)) + 1;
        const itinerary = [];
        const activities = [
            {
                time: '09:00',
                title: 'Breakfast',
                desc: 'Start your day with local cuisine',
            },
            {
                time: '10:30',
                title: 'Morning Activity',
                desc: 'Explore main attractions',
            },
            {
                time: '13:00',
                title: 'Lunch',
                desc: 'Try recommended restaurants',
            },
            {
                time: '15:00',
                title: 'Afternoon Activity',
                desc: 'Visit cultural sites',
            },
            {
                time: '18:00',
                title: 'Evening Activity',
                desc: 'Enjoy sunset views',
            },
            {
                time: '20:00',
                title: 'Dinner',
                desc: 'Experience local nightlife',
            },
        ];
        for (let i = 0; i < days; i++) {
            const currentDate = new Date(start);
            currentDate.setDate(start.getDate() + i);
            const checkpoints = activities.map((act, idx) => ({
                time: act.time,
                title: `${act.title} in ${destination}`,
                description: act.desc,
                completed: false,
                sort_order: idx,
            }));
            itinerary.push({
                day_number: i + 1,
                title: i === 0
                    ? 'Arrival Day'
                    : i === days - 1
                        ? 'Departure Day'
                        : `Day ${i + 1}`,
                date: currentDate
                    .toISOString()
                    .split('T')[0],
                checkpoints,
            });
        }
        return itinerary;
    }
}
exports.TripsService = TripsService;
//# sourceMappingURL=trips.service.js.map