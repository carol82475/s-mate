"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.EmergencyService = void 0;
class EmergencyService {
    async getEmergencyContacts() {
        return [
            {
                id: '1',
                name: 'Police',
                number: '113',
                icon: 'police',
                description: 'For crimes, theft, and security issues',
            },
            {
                id: '2',
                name: 'Ambulance',
                number: '115',
                icon: 'ambulance',
                description: 'For medical emergencies',
            },
            {
                id: '3',
                name: 'Fire Department',
                number: '114',
                icon: 'fire',
                description: 'For fire and rescue emergencies',
            },
            {
                id: '4',
                name: 'Tourist Hotline',
                number: '1800-1234',
                icon: 'info',
                description: 'For tourist assistance and information',
            },
        ];
    }
    async getQuickPhrases(language = 'vi') {
        const phrases = {
            vi: [
                { id: '1', phrase: 'Xin chào', translation: 'Hello', pronunciation: 'sin chow' },
                { id: '2', phrase: 'Cảm ơn', translation: 'Thank you', pronunciation: 'gam un' },
                { id: '3', phrase: 'Xin lỗi', translation: 'Sorry', pronunciation: 'sin loy' },
                { id: '4', phrase: 'Tôi cần giúp đỡ', translation: 'I need help', pronunciation: 'toy gun zup dop' },
                { id: '5', phrase: 'Bệnh viện ở đâu?', translation: 'Where is the hospital?', pronunciation: 'ben vien ur dow' },
                { id: '6', phrase: 'Gọi cảnh sát', translation: 'Call the police', pronunciation: 'goy gan sat' },
                { id: '7', phrase: 'Tôi bị lạc', translation: 'I am lost', pronunciation: 'toy bee lac' },
                { id: '8', phrase: 'Bao nhiêu tiền?', translation: 'How much?', pronunciation: 'bow new tien' },
            ],
            en: [
                { id: '1', phrase: 'Hello', translation: 'Xin chào', pronunciation: 'hello' },
                { id: '2', phrase: 'Thank you', translation: 'Cảm ơn', pronunciation: 'thank you' },
                { id: '3', phrase: 'Help!', translation: 'Giúp đỡ!', pronunciation: 'help' },
                { id: '4', phrase: 'Emergency', translation: 'Khẩn cấp', pronunciation: 'emergency' },
            ],
        };
        return phrases[language] || phrases.vi;
    }
    async getSafetyTips() {
        return [
            {
                id: '1',
                title: 'Keep Valuables Safe',
                description: 'Use hotel safes for passports, cash, and electronics. Avoid displaying expensive items in public.',
                icon: 'lock',
            },
            {
                id: '2',
                title: 'Stay Connected',
                description: 'Keep your phone charged and have emergency contacts saved. Consider getting a local SIM card.',
                icon: 'phone',
            },
            {
                id: '3',
                title: 'Know Your Location',
                description: 'Always know your hotel address in local language. Take a business card from your hotel.',
                icon: 'map',
            },
            {
                id: '4',
                title: 'Food & Water Safety',
                description: 'Drink bottled water. Eat at busy restaurants. Avoid raw or undercooked food from street vendors.',
                icon: 'restaurant',
            },
            {
                id: '5',
                title: 'Transportation Safety',
                description: 'Use official taxis or ride-hailing apps. Agree on fare before starting. Wear helmet on motorbikes.',
                icon: 'car',
            },
            {
                id: '6',
                title: 'Scam Awareness',
                description: 'Be cautious of overly friendly strangers. Verify prices before purchasing. Avoid unofficial tour guides.',
                icon: 'warning',
            },
        ];
    }
    async makeEmergencyCall(type, location) {
        // Placeholder for emergency call functionality
        // In production, this would integrate with actual emergency services
        return {
            message: 'Emergency call initiated',
            type,
            location: location || 'Unknown',
            timestamp: new Date(),
            callId: `EMG-${Date.now()}`,
        };
    }
}
exports.EmergencyService = EmergencyService;
//# sourceMappingURL=emergency.service.js.map