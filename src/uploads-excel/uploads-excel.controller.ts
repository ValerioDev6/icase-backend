import {
  Controller,
  FileTypeValidator,
  ParseFilePipe,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { UploadsExcelService } from './uploads-excel.service';
import { Logger } from 'winston';
import { FileInterceptor } from '@nestjs/platform-express';

@Controller('uploads-excel')
export class UploadsExcelController {
  constructor(private readonly uploadsExcelService: UploadsExcelService) {}

  @Post('productos')
  @UseInterceptors(FileInterceptor('file'))
  async uploadProductosExcel(
    @UploadedFile(
      new ParseFilePipe({
        validators: [new FileTypeValidator({ fileType: /(csv|excel)$/ })],
      }),
    )
    file: Express.Multer.File,
  ) {
    return this.uploadsExcelService.uploadExcelProducto(file);
  }
}
