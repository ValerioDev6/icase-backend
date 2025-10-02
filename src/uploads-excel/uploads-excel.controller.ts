import {
  Controller,
  FileTypeValidator,
  ParseFilePipe,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { SkipThrottle } from '@nestjs/throttler';
import { UploadsExcelService } from './uploads-excel.service';
@SkipThrottle()
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
