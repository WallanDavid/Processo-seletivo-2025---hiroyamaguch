import { Injectable } from '@nestjs/common';
import axios from 'axios';
import { ClientsService } from '../clients/clients.service';

const PROVIDERS = {
  brazilian: 'http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/brazilian_provider',
  european: 'http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/european_provider',
};

@Injectable()
export class ProductsService {
  constructor(private clients: ClientsService) {}

  private async resolveProviderByHost(host?: string, clientSlug?: string) {
    const slug = clientSlug || host;
    if (!slug) return 'brazilian' as const; // default
    const client = await this.clients.findBySlug(slug);
    return client?.provider || 'brazilian';
  }

  async list(host?: string, search?: string, clientSlug?: string) {
    const provider = await this.resolveProviderByHost(host, clientSlug);
    const url = PROVIDERS[provider];
    const { data } = await axios.get(url);
    let products = Array.isArray(data) ? data : [];
    if (search) {
      const q = search.toLowerCase();
      products = products.filter(
        (p) => String(p?.name || '').toLowerCase().includes(q) || String(p?.description || '').toLowerCase().includes(q),
      );
    }
    return { provider, items: products };
  }

  async byId(id: string, host?: string, clientSlug?: string) {
    const provider = await this.resolveProviderByHost(host, clientSlug);
    const base = PROVIDERS[provider];
    const { data } = await axios.get(`${base}/${id}`);
    return { provider, item: data };
  }
}
