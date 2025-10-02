import { Module } from '@nestjs/common';
import { AuthModule } from 'src/auth/auth.module';
import { PrismaModule } from 'src/prisma/prima.module';
import { BasicReportsExcelController } from './basic-reports-excel.controller';
import { BasicReportsExcelService } from './basic-reports-excel.service';

@Module({
  controllers: [BasicReportsExcelController],
  imports: [PrismaModule, AuthModule],
  providers: [BasicReportsExcelService],
})
export class BasicReportsExcelModule {}
