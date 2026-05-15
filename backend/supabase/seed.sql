-- Seed emergency contacts
INSERT INTO emergency_contacts (country, service_name, phone_number, type, description) VALUES
('Vietnam', 'Police', '113', 'police', 'For crimes, theft, and security issues'),
('Vietnam', 'Ambulance', '115', 'ambulance', 'For medical emergencies'),
('Vietnam', 'Fire Department', '114', 'fire', 'For fire and rescue emergencies'),
('Vietnam', 'Tourist Hotline', '1800-1234', 'tourist', 'For tourist assistance and information');

-- Seed safety tips
INSERT INTO safety_tips (country, title, content, category, icon) VALUES
('Vietnam', 'Keep Valuables Safe', 'Use hotel safes for passports, cash, and electronics. Avoid displaying expensive items in public.', 'security', 'lock'),
('Vietnam', 'Stay Connected', 'Keep your phone charged and have emergency contacts saved. Consider getting a local SIM card.', 'communication', 'phone'),
('Vietnam', 'Know Your Location', 'Always know your hotel address in local language. Take a business card from your hotel.', 'navigation', 'map'),
('Vietnam', 'Food & Water Safety', 'Drink bottled water. Eat at busy restaurants. Avoid raw or undercooked food from street vendors.', 'health', 'restaurant'),
('Vietnam', 'Transportation Safety', 'Use official taxis or ride-hailing apps. Agree on fare before starting. Wear helmet on motorbikes.', 'transport', 'car'),
('Vietnam', 'Scam Awareness', 'Be cautious of overly friendly strangers. Verify prices before purchasing. Avoid unofficial tour guides.', 'safety', 'warning');

-- Seed quick phrases (Vietnamese)
INSERT INTO quick_phrases (language, category, original_text, translated_text, pronunciation) VALUES
('vi', 'greetings', 'Xin chào', 'Hello', 'sin chow'),
('vi', 'greetings', 'Cảm ơn', 'Thank you', 'gam un'),
('vi', 'greetings', 'Xin lỗi', 'Sorry', 'sin loy'),
('vi', 'emergency', 'Tôi cần giúp đỡ', 'I need help', 'toy gun zup dop'),
('vi', 'emergency', 'Bệnh viện ở đâu?', 'Where is the hospital?', 'ben vien ur dow'),
('vi', 'emergency', 'Gọi cảnh sát', 'Call the police', 'goy gan sat'),
('vi', 'navigation', 'Tôi bị lạc', 'I am lost', 'toy bee lac'),
('vi', 'shopping', 'Bao nhiêu tiền?', 'How much?', 'bow new tien');

-- Note: User data should be created through the application's registration flow
-- This ensures proper authentication and profile creation via triggers
