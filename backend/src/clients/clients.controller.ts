import { Controller, Get } from '@nestjs/common';
import { ClientsService } from './clients.service';

@Controller('clients')
export class ClientsController {
  constructor(private clients: ClientsService) {}

  @Get()
  list() {
    return this.clients.all();
  }
}
