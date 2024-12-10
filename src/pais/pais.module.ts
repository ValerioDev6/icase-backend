import { Module } from '@nestjs/common';
import { PaisService } from './pais.service';
import { PaisController } from './pais.controller';
import { PrismaModule } from 'src/prisma/prima.module';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  controllers: [PaisController],
  imports: [PrismaModule, AuthModule],
  providers: [PaisService],
})
export class PaisModule {}
