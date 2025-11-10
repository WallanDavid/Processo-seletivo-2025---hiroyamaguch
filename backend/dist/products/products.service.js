"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.ProductsService = void 0;
const common_1 = require("@nestjs/common");
const axios_1 = __importDefault(require("axios"));
const clients_service_1 = require("../clients/clients.service");
const PROVIDERS = {
    brazilian: 'http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/brazilian_provider',
    european: 'http://616d6bdb6dacbb001794ca17.mockapi.io/devnology/european_provider',
};
let ProductsService = class ProductsService {
    constructor(clients) {
        this.clients = clients;
    }
    async resolveProviderByHost(host, clientSlug) {
        const slug = clientSlug || host;
        if (!slug)
            return 'brazilian'; // default
        const client = await this.clients.findBySlug(slug);
        return (client === null || client === void 0 ? void 0 : client.provider) || 'brazilian';
    }
    async list(host, search, clientSlug) {
        const provider = await this.resolveProviderByHost(host, clientSlug);
        const url = PROVIDERS[provider];
        const { data } = await axios_1.default.get(url);
        let products = Array.isArray(data) ? data : [];
        if (search) {
            const q = search.toLowerCase();
            products = products.filter((p) => String((p === null || p === void 0 ? void 0 : p.name) || '').toLowerCase().includes(q) || String((p === null || p === void 0 ? void 0 : p.description) || '').toLowerCase().includes(q));
        }
        return { provider, items: products };
    }
    async byId(id, host, clientSlug) {
        const provider = await this.resolveProviderByHost(host, clientSlug);
        const base = PROVIDERS[provider];
        const { data } = await axios_1.default.get(`${base}/${id}`);
        return { provider, item: data };
    }
};
exports.ProductsService = ProductsService;
exports.ProductsService = ProductsService = __decorate([
    (0, common_1.Injectable)(),
    __metadata("design:paramtypes", [clients_service_1.ClientsService])
], ProductsService);
//# sourceMappingURL=products.service.js.map