"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const supabase_1 = require("../config/supabase");
const logger_1 = require("../core/logger/logger");
const seedDatabase = async () => {
    try {
        logger_1.logger.info('🌱 Starting database seed...');
        // Note: Users should be created through Supabase Auth signup
        // This seed script only seeds reference data
        // Seed emergency contacts
        logger_1.logger.info('Seeding emergency contacts...');
        await supabase_1.supabaseAdmin.from('emergency_contacts').delete().neq('id', '00000000-0000-0000-0000-000000000000');
        await supabase_1.supabaseAdmin.from('emergency_contacts').insert([
            {
                country: 'Vietnam',
                service_name: 'Police',
                phone_number: '113',
                type: 'police',
                description: 'For crimes, theft, and security issues',
            },
            {
                country: 'Vietnam',
                service_name: 'Ambulance',
                phone_number: '115',
                type: 'ambulance',
                description: 'For medical emergencies',
            },
            {
                country: 'Vietnam',
                service_name: 'Fire Department',
                phone_number: '114',
                type: 'fire',
                description: 'For fire and rescue emergencies',
            },
            {
                country: 'Vietnam',
                service_name: 'Tourist Hotline',
                phone_number: '1800-1234',
                type: 'tourist',
                description: 'For tourist assistance and information',
            },
        ]);
        // Seed safety tips
        logger_1.logger.info('Seeding safety tips...');
        await supabase_1.supabaseAdmin.from('safety_tips').delete().neq('id', '00000000-0000-0000-0000-000000000000');
        await supabase_1.supabaseAdmin.from('safety_tips').insert([
            {
                country: 'Vietnam',
                title: 'Keep Valuables Safe',
                content: 'Use hotel safes for passports, cash, and electronics. Avoid displaying expensive items in public.',
                category: 'security',
                icon: 'lock',
            },
            {
                country: 'Vietnam',
                title: 'Stay Connected',
                content: 'Keep your phone charged and have emergency contacts saved. Consider getting a local SIM card.',
                category: 'communication',
                icon: 'phone',
            },
            {
                country: 'Vietnam',
                title: 'Know Your Location',
                content: 'Always know your hotel address in local language. Take a business card from your hotel.',
                category: 'navigation',
                icon: 'map',
            },
            {
                country: 'Vietnam',
                title: 'Food & Water Safety',
                content: 'Drink bottled water. Eat at busy restaurants. Avoid raw or undercooked food from street vendors.',
                category: 'health',
                icon: 'restaurant',
            },
            {
                country: 'Vietnam',
                title: 'Transportation Safety',
                content: 'Use official taxis or ride-hailing apps. Agree on fare before starting. Wear helmet on motorbikes.',
                category: 'transport',
                icon: 'car',
            },
            {
                country: 'Vietnam',
                title: 'Scam Awareness',
                content: 'Be cautious of overly friendly strangers. Verify prices before purchasing. Avoid unofficial tour guides.',
                category: 'safety',
                icon: 'warning',
            },
        ]);
        // Seed quick phrases
        logger_1.logger.info('Seeding quick phrases...');
        await supabase_1.supabaseAdmin.from('quick_phrases').delete().neq('id', '00000000-0000-0000-0000-000000000000');
        await supabase_1.supabaseAdmin.from('quick_phrases').insert([
            {
                language: 'vi',
                category: 'greetings',
                original_text: 'Xin chào',
                translated_text: 'Hello',
                pronunciation: 'sin chow',
            },
            {
                language: 'vi',
                category: 'greetings',
                original_text: 'Cảm ơn',
                translated_text: 'Thank you',
                pronunciation: 'gam un',
            },
            {
                language: 'vi',
                category: 'greetings',
                original_text: 'Xin lỗi',
                translated_text: 'Sorry',
                pronunciation: 'sin loy',
            },
            {
                language: 'vi',
                category: 'emergency',
                original_text: 'Tôi cần giúp đỡ',
                translated_text: 'I need help',
                pronunciation: 'toy gun zup dop',
            },
            {
                language: 'vi',
                category: 'emergency',
                original_text: 'Bệnh viện ở đâu?',
                translated_text: 'Where is the hospital?',
                pronunciation: 'ben vien ur dow',
            },
            {
                language: 'vi',
                category: 'emergency',
                original_text: 'Gọi cảnh sát',
                translated_text: 'Call the police',
                pronunciation: 'goy gan sat',
            },
            {
                language: 'vi',
                category: 'navigation',
                original_text: 'Tôi bị lạc',
                translated_text: 'I am lost',
                pronunciation: 'toy bee lac',
            },
            {
                language: 'vi',
                category: 'shopping',
                original_text: 'Bao nhiêu tiền?',
                translated_text: 'How much?',
                pronunciation: 'bow new tien',
            },
        ]);
        logger_1.logger.info('✅ Database seeded successfully!');
        logger_1.logger.info('');
        logger_1.logger.info('📝 To create test users:');
        logger_1.logger.info('1. Use Supabase Auth signup in your app');
        logger_1.logger.info('2. Or use Supabase dashboard to create users');
        logger_1.logger.info('3. Profiles will be auto-created via trigger');
        logger_1.logger.info('');
        process.exit(0);
    }
    catch (error) {
        logger_1.logger.error('❌ Error seeding database:', error);
        process.exit(1);
    }
};
seedDatabase();
//# sourceMappingURL=seed.js.map