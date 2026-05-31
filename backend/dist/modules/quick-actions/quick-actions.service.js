"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.QuickActionsService = void 0;
const supabase_1 = require("../../config/supabase");
class QuickActionsService {
    async getQuickActions(userId) {
        // Get user's active trip
        const { data: activeTrip } = await supabase_1.supabaseAdmin
            .from('trips')
            .select('id')
            .eq('user_id', userId)
            .eq('status', 'active')
            .single();
        const actions = [
            {
                id: '1',
                title: 'Plan New Trip',
                icon: 'add_circle',
                route: '/trip-planner',
                color: '#FFB088',
            },
            {
                id: '2',
                title: 'Find Travelers',
                icon: 'people',
                route: '/find-travelers',
                color: '#607D8B',
            },
            {
                id: '3',
                title: 'AI Assistant',
                icon: 'smart_toy',
                route: '/ai-chat',
                color: '#27AE60',
            },
            {
                id: '4',
                title: 'Explore Map',
                icon: 'map',
                route: '/map',
                color: '#FF9E7D',
            },
        ];
        if (activeTrip) {
            actions.unshift({
                id: '0',
                title: 'Current Trip',
                icon: 'flight_takeoff',
                route: `/itinerary/${activeTrip.id}`,
                color: '#D4183D',
            });
        }
        return actions;
    }
}
exports.QuickActionsService = QuickActionsService;
//# sourceMappingURL=quick-actions.service.js.map