import { Controller, Get, Headers, Param, Query } from '@nestjs/common';
import { ProductsService } from './products.service';

@Controller('products')
export class ProductsController {
  constructor(private products: ProductsService) {}

  @Get()
  list(
    @Headers('host') host?: string,
    @Query('search') search?: string,
    @Query('client') clientSlug?: string,
  ) {
    return this.products.list(host, search, clientSlug);
  }

  @Get(':id')
  byId(
    @Param('id') id: string,
    @Headers('host') host?: string,
    @Query('client') clientSlug?: string,
  ) {
    return this.products.byId(id, host, clientSlug);
  }
}
