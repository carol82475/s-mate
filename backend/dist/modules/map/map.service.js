"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MapService = void 0;
class MapService {
    async searchPlaces(query, category, _latitude, _longitude) {
        // Mock places data
        const mockPlaces = [
            {
                id: '1',
                name: 'Hoan Kiem Lake',
                category: 'Landmark',
                rating: 4.5,
                distance: '0.5 km',
                latitude: 21.0285,
                longitude: 105.8542,
                address: 'Hoan Kiem District, Hanoi',
                description: 'Historic lake in the heart of Hanoi',
            },
            {
                id: '2',
                name: 'Temple of Literature',
                category: 'Cultural',
                rating: 4.7,
                distance: '1.2 km',
                latitude: 21.0277,
                longitude: 105.8355,
                address: 'Dong Da District, Hanoi',
                description: 'Vietnam\'s first national university',
            },
            {
                id: '3',
                name: 'Old Quarter',
                category: 'Shopping',
                rating: 4.6,
                distance: '0.8 km',
                latitude: 21.0368,
                longitude: 105.8495,
                address: 'Hoan Kiem District, Hanoi',
                description: 'Historic commercial district',
            },
            {
                id: '4',
                name: 'Pho Gia Truyen',
                category: 'Restaurant',
                rating: 4.8,
                distance: '0.3 km',
                latitude: 21.0313,
                longitude: 105.8516,
                address: '49 Bat Dan, Hanoi',
                description: 'Famous Vietnamese pho restaurant',
            },
            {
                id: '5',
                name: 'Thang Long Water Puppet',
                category: 'Entertainment',
                rating: 4.4,
                distance: '0.6 km',
                latitude: 21.0289,
                longitude: 105.8521,
                address: '57B Dinh Tien Hoang, Hanoi',
                description: 'Traditional water puppet theater',
            },
        ];
        let filteredPlaces = mockPlaces;
        if (query) {
            const lowerQuery = query.toLowerCase();
            filteredPlaces = filteredPlaces.filter((place) => place.name.toLowerCase().includes(lowerQuery) ||
                place.description.toLowerCase().includes(lowerQuery));
        }
        if (category) {
            filteredPlaces = filteredPlaces.filter((place) => place.category.toLowerCase() === category.toLowerCase());
        }
        return filteredPlaces;
    }
    async getPlaceById(placeId) {
        const mockPlace = {
            id: placeId,
            name: 'Hoan Kiem Lake',
            category: 'Landmark',
            rating: 4.5,
            distance: '0.5 km',
            latitude: 21.0285,
            longitude: 105.8542,
            address: 'Hoan Kiem District, Hanoi',
            description: 'Historic lake in the heart of Hanoi',
            openingHours: '24/7',
            phone: '+84 24 3825 4854',
            website: 'https://example.com',
            photos: [
                'https://picsum.photos/400/300?random=1',
                'https://picsum.photos/400/300?random=2',
            ],
            reviews: [
                {
                    userName: 'John Doe',
                    rating: 5,
                    comment: 'Beautiful place to visit!',
                    date: new Date(),
                },
            ],
        };
        return mockPlace;
    }
    async getNearbyPlaces(_latitude, _longitude, _radius = 5) {
        // Return mock nearby places
        return this.searchPlaces();
    }
}
exports.MapService = MapService;
//# sourceMappingURL=map.service.js.map