import { Controller, Get } from '@nestjs/common';

@Controller('users')
export class UsersController {
  @Get('me')
  me() {
    // Placeholder; would require auth guard to return current user
    return { ok: true };
  }
}
