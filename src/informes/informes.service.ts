import {
  BadRequestException,
  HttpException,
  Injectable,
  InternalServerErrorException,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { FilterVentasReportDto } from './dtos/filter-ventas.dto';
import { Prisma } from '@prisma/client';
import { getVentasReport } from 'src/reports/pdf/ventas.report';
import { PrinterService } from 'src/printer/printer.service';
import { FilterComprasReportDto } from './dtos/filter-compras.dto';
import { getComprasReport } from 'src/reports/pdf/compras_pdf.report';
import { FilterProveedoresReportDto } from './dtos/filter-proveedores.dto';
import { getProveedoresReport } from 'src/reports/pdf/proveedor.report';

@Injectable()
export class InformesService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly printerService: PrinterService,
  ) {}
  private readonly logger = new Logger('InformesService');

  async getVentasByDateRange(filterDto: FilterVentasReportDto) {
    try {
      const { fecha_inicio, fecha_fin, page = 1, limit = 10 } = filterDto;

      const filters: any = {};

      // Filtros por rango de fechas
      if (fecha_inicio && fecha_fin) {
        filters.created_at = {
          gte: new Date(fecha_inicio),
          lte: new Date(fecha_fin),
        };
      }

      // Consulta de datos con paginación
      const [ventas, total] = await Promise.all([
        this.prisma.tb_ventas.findMany({
          skip: (page - 1) * limit,
          take: limit,
          where: filters,
          include: {
            tb_cliente: {
              include: {
                tb_personas: true,
              },
            },
            tb_personal: {
              include: {
                tb_personas: true,
              },
            },
            tb_metodo_pago: true,
          },
          orderBy: {
            created_at: 'desc',
          },
        }),
        this.prisma.tb_ventas.count({ where: filters }), // Total de registros para la paginación
      ]);

      // Retorno con información de paginación
      return {
        info: {
          page,
          limit,
          total,
          next: `${process.env.HOST_API}/informes?page=${page + 1}&limit=${limit}`,
          prev:
            page > 1 ? `${process.env.HOST_API}/informes?page=${page - 1}&limit=${limit}` : null,
        },
        ventas,
      };
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  async getVentasByDateRangeSinPaginacion(filterDto: FilterVentasReportDto) {
    const { fecha_inicio, fecha_fin } = filterDto;

    const filters: any = {};
    if (fecha_inicio && fecha_fin) {
      filters.created_at = {
        gte: new Date(fecha_inicio),
        lte: new Date(fecha_fin),
      };
    }

    return await this.prisma.tb_ventas.findMany({
      where: filters,
      include: {
        tb_cliente: { include: { tb_personas: true } },
        tb_personal: { include: { tb_personas: true } },
        tb_metodo_pago: true,
      },
      orderBy: { created_at: 'desc' },
    });
  }

  async createVentasReportByDateRange(filterDto) {
    try {
      const ventas = await this.getVentasByDateRangeSinPaginacion(filterDto);

      if (!ventas) {
        throw new Error('No se encontraron ventas en el rango de fechas proporcionado');
      }

      const docDefinition = getVentasReport({ ventas });
      return this.printerService.createPdf(docDefinition);
    } catch (error) {
      console.error('Error al generar el reporte de ventas filtradas:', error);
      throw new Error('Error al generar el reporte de ventas filtradas');
    }
  }

  // area de compras

  async getComprasByDateRange(filterDto: FilterComprasReportDto) {
    try {
      const { fecha_inicio, fecha_fin, page = 1, limit = 10 } = filterDto;

      const filters: any = {};

      // Filtros por rango de fechas
      if (fecha_inicio && fecha_fin) {
        filters.fecha_compra = {
          gte: new Date(fecha_inicio),
          lte: new Date(fecha_fin),
        };
      }

      // Consulta de datos con paginación
      const [compras, total] = await Promise.all([
        this.prisma.tb_compra.findMany({
          skip: (page - 1) * limit,
          take: limit,
          where: filters,
          include: {
            tb_proveedores: {
              include: {
                tb_personas: true,
              },
            },

            tb_metodo_pago: true,
          },
          orderBy: {
            fecha_compra: 'desc',
          },
        }),
        this.prisma.tb_compra.count({ where: filters }), // Total de registros para la paginación
      ]);

      // Retorno con información de paginación
      return {
        info: {
          page,
          limit,
          total,
          next: `${process.env.HOST_API}/informes?page=${page + 1}&limit=${limit}`,
          prev:
            page > 1 ? `${process.env.HOST_API}/informes?page=${page - 1}&limit=${limit}` : null,
        },
        compras,
      };
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  async getComprasByDateRangeSinPagination(filterDto: FilterComprasReportDto) {
    const { fecha_inicio, fecha_fin } = filterDto;

    const filters: any = {};
    if (fecha_inicio && fecha_fin) {
      filters.fecha_compra = {
        gte: new Date(fecha_inicio),
        lte: new Date(fecha_fin),
      };
    }

    return await this.prisma.tb_compra.findMany({
      where: filters,
      include: {
        tb_proveedores: { include: { tb_personas: true } },
        tb_metodo_pago: true,
      },
      orderBy: { fecha_compra: 'desc' },
    });
  }

  async createComprasReportByDateRange(filterDto) {
    try {
      const compras = await this.getComprasByDateRangeSinPagination(filterDto);

      if (!compras) {
        throw new Error('No se encontraron compras en el rango de fechas proporcionado');
      }

      const docDefinition = getComprasReport({ compras });
      return this.printerService.createPdf(docDefinition);
    } catch (error) {
      console.error('Error al generar el reporte de ventas filtradas:', error);
      throw new Error('Error al generar el reporte de ventas filtradas');
    }
  }

  private handleExceptions(error: any) {
    this.logger.error(error);
    if (error instanceof HttpException) {
      throw error;
    }
    if (error instanceof Prisma.PrismaClientKnownRequestError) {
      switch (error.code) {
        case 'P2002':
          throw new BadRequestException('Ya existe un registro con esos datos únicos');
        case 'P2014':
          throw new BadRequestException('El registro viola una restricción de relación');
        case 'P2003':
          throw new BadRequestException('El registro viola una restricción de clave foránea');
        case 'P2025':
          throw new NotFoundException('No se encontró el registro para actualizar o eliminar');
      }
    }

    if (error instanceof NotFoundException) {
      throw error;
    }

    throw new InternalServerErrorException(
      'Ocurrió un error inesperado. Por favor, contacte al administrador.',
    );
  }
}
