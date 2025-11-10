import { Module } from '@nestjs/common';
import { Client } from './client.entity';
import { ClientsService } from './clients.service';
import { ClientsController } from './clients.controller';

@Module({
  providers: [ClientsService],
  exports: [ClientsService],
  controllers: [ClientsController],
})
export class ClientsModule {}
