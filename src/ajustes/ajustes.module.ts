import { Module } from '@nestjs/common';
import { AjustesService } from './ajustes.service';
import { AjustesController } from './ajustes.controller';
import { PrismaModule } from 'src/prisma/prima.module';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  controllers: [AjustesController],
  imports: [PrismaModule, AuthModule],
  providers: [AjustesService],
})
export class AjustesModule {}
