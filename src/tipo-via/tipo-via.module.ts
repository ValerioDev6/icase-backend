import { Module } from '@nestjs/common';
import { AuthModule } from 'src/auth/auth.module';
import { PrismaModule } from 'src/prisma/prima.module';
import { TipoViaController } from './tipo-via.controller';
import { TipoViaService } from './tipo-via.service';

@Module({
  controllers: [TipoViaController],
  imports: [PrismaModule, AuthModule],
  providers: [TipoViaService],
  exports: [TipoViaService],
})
export class TipoViaModule {}
