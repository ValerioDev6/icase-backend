import { Module } from '@nestjs/common';
import { AuthModule } from 'src/auth/auth.module';
import { PrismaModule } from 'src/prisma/prima.module';
import { UploadsExcelController } from './uploads-excel.controller';
import { UploadsExcelService } from './uploads-excel.service';

@Module({
  controllers: [UploadsExcelController],
  imports: [AuthModule, PrismaModule],
  providers: [UploadsExcelService],
})
export class UploadsExcelModule {}
