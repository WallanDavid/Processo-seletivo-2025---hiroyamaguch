import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

export type ProviderKey = 'brazilian' | 'european';

@Entity('clients')
export class Client {
  @PrimaryGeneratedColumn('uuid')
  id!: string;

  @Column({ unique: true })
  slug!: string; // ex: brazil.in8.local

  @Column()
  name!: string;

  @Column({ type: 'text' })
  provider!: ProviderKey; // brazilian | european
}
