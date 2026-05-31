"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.initializeSupabase = exports.supabase = exports.supabaseAdmin = void 0;
const supabase_js_1 = require("@supabase/supabase-js");
const ws_1 = __importDefault(require("ws"));
const env_1 = require("./env");
exports.supabaseAdmin = (0, supabase_js_1.createClient)(env_1.config.supabase.url, env_1.config.supabase.serviceRoleKey, {
    auth: {
        autoRefreshToken: false,
        persistSession: false,
    },
    realtime: {
        transport: ws_1.default,
    },
});
exports.supabase = (0, supabase_js_1.createClient)(env_1.config.supabase.url, env_1.config.supabase.anonKey, {
    realtime: {
        transport: ws_1.default,
    },
});
const initializeSupabase = async () => {
    try {
        const { error } = await exports.supabaseAdmin.auth.admin.listUsers({
            page: 1,
            perPage: 1,
        });
        if (error) {
            console.error('Supabase connection failed:', error.message);
            process.exit(1);
        }
        console.log('Supabase connected successfully');
    }
    catch (error) {
        console.error('Supabase initialization failed:', error);
        process.exit(1);
    }
};
exports.initializeSupabase = initializeSupabase;
//# sourceMappingURL=supabase.js.map