import { Module } from '@nestjs/common';
import { UploadsExcelService } from './uploads-excel.service';
import { UploadsExcelController } from './uploads-excel.controller';
import { AuthModule } from 'src/auth/auth.module';
import { PrismaModule } from 'src/prisma/prima.module';

@Module({
  controllers: [UploadsExcelController],
  imports: [AuthModule, PrismaModule],
  providers: [UploadsExcelService],
})
export class UploadsExcelModule {}
