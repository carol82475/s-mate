import { NotFoundError } from '../../core/errors/AppError';
import { TravelersRepository } from './travelers.repository';

export class TravelersService {
  private repository: TravelersRepository;

  constructor() {
    this.repository = new TravelersRepository();
  }

  async searchTravelers(query?: string, country?: string, interest?: string, page = 1, limit = 20) {
    const offset = (page - 1) * limit;

    const { travelers, count } = await this.repository.searchTravelers(
      query,
      country,
      interest,
      offset,
      limit
    );

    return {
      travelers,
      pagination: {
        page,
        limit,
        total: count,
        totalPages: Math.ceil(count / limit),
      },
    };
  }

  async getTravelerById(travelerId: string) {
    const traveler = await this.repository.findById(travelerId);

    if (!traveler) throw new NotFoundError('Traveler not found');

    return traveler;
  }

  async getOnlineTravelers(limit = 20) {
    return await this.repository.findOnlineTravelers(limit);
  }
}
