import { Injectable, OnModuleInit } from '@nestjs/common';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService implements OnModuleInit {
  private users: Array<{ id: string; email: string; passwordHash: string; role: string }> = [];

  async onModuleInit() {
    const email = 'admin@in8.com.br';
    const existing = this.users.find((u) => u.email === email);
    if (!existing) {
      const passwordHash = await bcrypt.hash('admin123', 10);
      this.users.push({ id: '1', email, passwordHash, role: 'admin' });
      console.log('Seeded default user: admin@in8.com.br / admin123');
    }
  }

  findByEmail(email: string) {
    return Promise.resolve(this.users.find((u) => u.email === email) || null);
  }
}
