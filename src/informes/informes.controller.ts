import { Controller, Get, Query, Res } from '@nestjs/common';
import { InformesService } from './informes.service';
import { FilterVentasReportDto } from './dtos/filter-ventas.dto';
import { Response } from 'express';
import { SkipThrottle } from '@nestjs/throttler';
import { Auth } from 'src/auth/decorators/auth.decorator';
import { FilterComprasReportDto } from './dtos/filter-compras.dto';
@Auth()
@SkipThrottle()
@Controller('informes')
export class InformesController {
  constructor(private readonly informesService: InformesService) {}

  @Get('ventas')
  findAll(@Query() filterDto: FilterVentasReportDto) {
    return this.informesService.getVentasByDateRange(filterDto);
  }

  @Get('ventas/reporte')
  async getVentasReport(@Query() filterDto: FilterVentasReportDto, @Res() response: Response) {
    const pdfDoc = await this.informesService.createVentasReportByDateRange(filterDto);

    response.setHeader('Content-Type', 'application/pdf');
    pdfDoc.info.Title = 'Reporte de Ventas';
    pdfDoc.pipe(response);
    pdfDoc.end();
  }

  @Get('compras')
  findAllCompras(@Query() filterDto: FilterComprasReportDto) {
    return this.informesService.getComprasByDateRange(filterDto);
  }

  @Get('compras/informe')
  async getComprasReport(@Query() filterDto: FilterComprasReportDto, @Res() response: Response) {
    const pdfDoc = await this.informesService.createComprasReportByDateRange(filterDto);

    response.setHeader('Content-Type', 'application/pdf');
    pdfDoc.info.Title = 'Reporte de Compras ';
    pdfDoc.pipe(response);
    pdfDoc.end();
  }
}
