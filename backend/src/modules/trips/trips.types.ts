export interface Trip {
  id: string;
  user_id: string;
  destination: string;
  start_date: string;
  end_date: string;
  budget?: number;
  traveler_count: number;
  preferences: string[];
  status: 'planning' | 'active' | 'completed' | 'cancelled';
  progress: number;
  created_at: string;
  updated_at: string;
}

export interface ItineraryDay {
  id: string;
  trip_id: string;
  day_number: number;
  title: string;
  date?: string;
  created_at: string;
  updated_at: string;
}

export interface Checkpoint {
  id: string;
  itinerary_day_id: string;
  time: string;
  title: string;
  description: string;
  completed: boolean;
  sort_order: number;
  created_at: string;
  updated_at: string;
}

export interface CreateTripDTO {
  destination: string;
  start_date: string;
  end_date: string;
  budget?: number;
  description?: string;
  travelers: number;
  travelers_label?: string;
  preferences?: string[];
}

export interface UpdateTripDTO {
  destination?: string;
  start_date?: string;
  end_date?: string;
  budget?: number;
  traveler_count?: number;
  preferences?: string[];
  status?: 'planning' | 'active' | 'completed' | 'cancelled';
  progress?: number;
}

export interface FrontendItineraryDay {
  id: string;
  day: number;
  day_number: number;
  title: string;
  date?: string;
  checkpoints: Array<{
    id: string;
    time: string;
    title: string;
    description: string;
    completed: boolean;
    sort_order: number;
  }>;
}

export interface TripWithItinerary extends Trip {
  itinerary_days: Array<ItineraryDay & { checkpoints: Checkpoint[] }>;
  itinerary: FrontendItineraryDay[];
}

export interface ItineraryDayInput {
  day_number: number;
  title: string;
  date?: string;
  checkpoints: Array<{
    time: string;
    title: string;
    description: string;
    completed: boolean;
    sort_order: number;
  }>;
}