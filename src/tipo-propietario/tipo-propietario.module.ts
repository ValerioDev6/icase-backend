import { Module } from '@nestjs/common';
import { AuthModule } from 'src/auth/auth.module';
import { PrismaModule } from 'src/prisma/prima.module';
import { TipoPropietarioController } from './tipo-propietario.controller';
import { TipoPropietarioService } from './tipo-propietario.service';

@Module({
  controllers: [TipoPropietarioController],
  imports: [PrismaModule, AuthModule],
  providers: [TipoPropietarioService],
})
export class TipoPropietarioModule {}
