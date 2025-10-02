import { Module } from '@nestjs/common';
import { InformesService } from './informes.service';
import { InformesController } from './informes.controller';
import { AuthModule } from 'src/auth/auth.module';
import { PrismaModule } from 'src/prisma/prima.module';
import { PrinterModule } from 'src/printer/printer.module';

@Module({
  controllers: [InformesController],
  imports: [AuthModule, PrismaModule, PrinterModule],
  providers: [InformesService],
})
export class InformesModule {}
