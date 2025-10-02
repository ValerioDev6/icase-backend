import { Controller, Get, Param, Res } from '@nestjs/common';
import { BasicReportsService } from './basic-reports.service';
import { Response } from 'express';
import { SkipThrottle } from '@nestjs/throttler';

@SkipThrottle()
@Controller('reports-pdf')
export class BasicReportsController {
  constructor(private readonly basicReportsService: BasicReportsService) {}

  @Get('marcas')
  async getMarcas(@Res() response: Response) {
    const pdfDoc = await this.basicReportsService.getMarcasReportPdf();
    response.setHeader('Content-Type', 'application/pdf');
    pdfDoc.info.Title = 'Marcas Reportes';
    pdfDoc.pipe(response);
    pdfDoc.end();
  }

  @Get('productos')
  async getProductos(@Res() response: Response) {
    const pdfDoc = await this.basicReportsService.getProductosReportPdf();
    response.setHeader('Content-Type', 'application/pdf');
    pdfDoc.info.Title = 'Productos Reportes';
    pdfDoc.pipe(response);
    pdfDoc.end();
  }

  @Get('categorias')
  async getCategorias(@Res() response: Response) {
    const pdfDoc = await this.basicReportsService.getCategoriasReportPdfData();
    response.setHeader('Content-Type', 'application/pdf');
    pdfDoc.info.Title = 'Categorias Reportes';
    pdfDoc.pipe(response);
    pdfDoc.end();
  }

  @Get('compras')
  async getCompras(@Res() response: Response) {
    const pdfDoc = await this.basicReportsService.getComprasReporPdf();
    response.setHeader('Content-Type', 'application/pdf');
    pdfDoc.info.Title = 'Compras Reportes';
    pdfDoc.pipe(response);
    pdfDoc.end();
  }

  @Get('ventas')
  async geVentas(@Res() response: Response) {
    const pdfDoc = await this.basicReportsService.getVentasReportPdf();
    response.setHeader('Content-Type', 'application/pdf');
    pdfDoc.info.Title = 'Ventas Reportes';
    pdfDoc.pipe(response);
    pdfDoc.end();
  }

  @Get('ventas-ticket/:id')
  async geVentasTicket(@Param('id') id: string, @Res() response: Response) {
    const pdfDoc = await this.basicReportsService.getVentaTicketPdf(id);
    response.setHeader('Content-Type', 'application/pdf');
    pdfDoc.info.Title = 'Ventas Reportes';
    pdfDoc.pipe(response);
    pdfDoc.end();
  }

  @Get('proveedores')
  async getProveedores(@Res() response: Response) {
    const pdfDoc = await this.basicReportsService.getProveedoresReportPdf();
    response.setHeader('Content-Type', 'application/pdf');
    pdfDoc.info.Title = 'Proveedores Reportes';
    pdfDoc.pipe(response);
    pdfDoc.end();
  }
  @Get('kardex')
  async getKardex(@Res() response: Response) {
    const pdfDoc = await this.basicReportsService.getKardexReportPdf();
    response.setHeader('Content-Type', 'application/pdf');
    pdfDoc.info.Title = 'Ventas Reportes';
    pdfDoc.pipe(response);
    pdfDoc.end();
  }

  @Get('personal')
  async getPersonal(@Res() response: Response) {
    const pdfDoc = await this.basicReportsService.getPersonalReport();
    response.setHeader('Content-Type', 'application/pdf');
    pdfDoc.info.Title = 'Personal Reportes';
    pdfDoc.pipe(response);
    pdfDoc.end();
  }

  @Get('clientes')
  async getClientes(@Res() response: Response) {
    const pdfDoc = await this.basicReportsService.getClienteReportPdf();
    response.setHeader('Content-Type', 'application/pdf');
    pdfDoc.info.Title = 'Clientes Reportes';
    pdfDoc.pipe(response);
    pdfDoc.end();
  }
}
