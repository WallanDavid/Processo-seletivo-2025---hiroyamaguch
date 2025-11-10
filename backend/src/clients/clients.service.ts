import { Injectable, OnModuleInit } from '@nestjs/common';
import { ProviderKey } from './client.entity';

@Injectable()
export class ClientsService implements OnModuleInit {
  private clients: Array<{ slug: string; name: string; provider: ProviderKey }> = [];

  async onModuleInit() {
    const seeds: Array<{ slug: string; name: string; provider: ProviderKey }> = [
      { slug: 'brazil.in8.local', name: 'Loja Brasil', provider: 'brazilian' },
      { slug: 'europe.in8.local', name: 'Loja Europa', provider: 'european' },
    ];
    this.clients = seeds;
    console.log('Seeded clients for whitelabel');
  }

  async findBySlug(slug: string) {
    return this.clients.find((c) => c.slug === slug) || null;
  }

  async all() {
    return this.clients;
  }
}
