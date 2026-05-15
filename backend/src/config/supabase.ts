import { createClient, SupabaseClient } from '@supabase/supabase-js';
import ws from 'ws';

import { config } from './env';

export const supabaseAdmin: SupabaseClient = createClient(
  config.supabase.url,
  config.supabase.serviceRoleKey,
  {
    auth: {
      autoRefreshToken: false,
      persistSession: false,
    },
    realtime: {
      transport: ws as any,
    },
  }
);

export const supabase: SupabaseClient = createClient(
  config.supabase.url,
  config.supabase.anonKey,
  {
    realtime: {
      transport: ws as any,
    },
  }
);

export const initializeSupabase = async (): Promise<void> => {
  try {
    const { error } = await supabaseAdmin.auth.admin.listUsers({
      page: 1,
      perPage: 1,
    });

    if (error) {
      console.error('Supabase connection failed:', error.message);
      process.exit(1);
    }

    console.log('Supabase connected successfully');
  } catch (error) {
    console.error('Supabase initialization failed:', error);
    process.exit(1);
  }
};