"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AiChatService = void 0;
const ai_chat_repository_1 = require("./ai-chat.repository");
class AiChatService {
    constructor() {
        this.repository = new ai_chat_repository_1.AiChatRepository();
    }
    async sendMessage(userId, message) {
        // Save user message
        await this.repository.createMessage({
            user_id: userId,
            role: 'user',
            content: message,
        });
        // Generate AI response
        const aiResponse = this.generateMockResponse(message);
        // Save AI response
        await this.repository.createMessage({
            user_id: userId,
            role: 'assistant',
            content: aiResponse,
        });
        return {
            message: aiResponse,
            timestamp: new Date().toISOString(),
        };
    }
    async getChatHistory(userId, limit = 50) {
        const messages = await this.repository.findMessagesByUserId(userId, limit);
        return { messages: messages.reverse() };
    }
    async clearChatHistory(userId) {
        await this.repository.deleteMessagesByUserId(userId);
        return { message: 'Chat history cleared' };
    }
    generateMockResponse(userMessage) {
        const lowerMessage = userMessage.toLowerCase();
        if (lowerMessage.includes('hotel') || lowerMessage.includes('accommodation')) {
            return 'I recommend checking out hotels in the city center for easy access to attractions. Popular areas include the Old Quarter in Hanoi or District 1 in Ho Chi Minh City. Would you like specific hotel recommendations based on your budget?';
        }
        if (lowerMessage.includes('food') || lowerMessage.includes('restaurant')) {
            return 'Vietnamese cuisine is amazing! Must-try dishes include Pho (noodle soup), Banh Mi (Vietnamese sandwich), and Bun Cha (grilled pork with noodles). I can recommend specific restaurants based on your location. What type of food are you interested in?';
        }
        if (lowerMessage.includes('weather') || lowerMessage.includes('climate')) {
            return 'Vietnam has a tropical climate with regional variations. The best time to visit is typically from November to April when the weather is cooler and drier. However, each region has its own ideal visiting season. Which part of Vietnam are you planning to visit?';
        }
        if (lowerMessage.includes('transport') || lowerMessage.includes('travel')) {
            return 'Getting around Vietnam is quite convenient! Options include domestic flights, trains, buses, and ride-hailing apps like Grab. For short distances, motorbike taxis (xe om) are popular. Would you like specific transportation recommendations for your route?';
        }
        if (lowerMessage.includes('visa') || lowerMessage.includes('passport')) {
            return 'Visa requirements vary by nationality. Many countries are eligible for visa exemption or e-visa. I recommend checking with the Vietnamese embassy or consulate in your country for the most up-to-date information. What is your nationality?';
        }
        if (lowerMessage.includes('budget') || lowerMessage.includes('cost')) {
            return 'Vietnam is generally budget-friendly! Daily costs can range from $30-50 for budget travelers to $100+ for mid-range comfort. Street food is incredibly cheap ($1-3 per meal), while mid-range restaurants cost $5-15. Would you like a detailed budget breakdown for your trip?';
        }
        if (lowerMessage.includes('attraction') || lowerMessage.includes('place')) {
            return 'Vietnam has incredible attractions! Popular destinations include Ha Long Bay, Hoi An Ancient Town, Hue Imperial City, Mekong Delta, and Sapa rice terraces. Each region offers unique experiences. What type of attractions interest you most - nature, culture, history, or adventure?';
        }
        return "I'm your AI travel assistant for Vietnam! I can help you with recommendations for hotels, restaurants, attractions, transportation, weather information, and travel tips. What would you like to know about your trip?";
    }
}
exports.AiChatService = AiChatService;
//# sourceMappingURL=ai-chat.service.js.map