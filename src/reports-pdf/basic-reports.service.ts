import { Injectable } from '@nestjs/common';
import { PrinterService } from 'src/printer/printer.service';
import { PrismaService } from 'src/prisma/prisma.service';
import { getHelloWordReport, getMarcasReport } from 'src/reports/pdf';
import { getProductosReport } from 'src/reports/pdf/productos.report';
import { getCategoriasReport } from '../reports/pdf/categorias.report';
import { getComprasReport } from 'src/reports/pdf/compras_pdf.report';
import { getProveedoresReport } from 'src/reports/pdf/proveedor.report';
import { getVentasReport } from 'src/reports/pdf/ventas.report';
import { getKardexReport } from 'src/reports/pdf/kardex-report-pdf';
import { getClienteReport } from 'src/reports/pdf/clientes.report';
import { getVentaTicket } from 'src/reports/pdf/ventas_ticket.report';
import { getPersonalReportPdf } from 'src/reports/pdf/personal.report';

@Injectable()
export class BasicReportsService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly printerService: PrinterService,
  ) {}

  hello() {
    const docDefinition = getHelloWordReport({
      name: 'Valerio',
    });
    const doc = this.printerService.createPdf(docDefinition);
    return doc;
  }

  async getMarcasReportPdf() {
    try {
      const marcas = await this.prisma.tb_marcas.findMany({
        select: {
          id_marca: true,
          nombre_marca: true,
          estado: true,
          created_at: true,
          updated_at: true,
        },
        orderBy: {
          nombre_marca: 'asc',
        },
      });

      const docDefinition = getMarcasReport({ marcas });
      return this.printerService.createPdf(docDefinition);
    } catch (error) {
      console.error('Error generating PDF:', error);
      throw new Error('Failed to generate PDF report');
    }
  }

  async getProductosReportPdf() {
    try {
      const productos = await this.prisma.tb_productos.findMany({
        select: {
          nombre_producto: true,
          stock: true,
          precio_compra: true,
          precio_venta: true,
          fecha_ingreso: true,
          estado_produto: true,
          tb_categorias: {
            select: {
              nombre_cat: true,
            },
          },
          tb_marcas: {
            select: {
              nombre_marca: true,
            },
          },
          tb_sucursales: {
            select: {
              nombre_sucursal: true,
            },
          },
          tb_tipo_propietario: {
            select: {
              descripcion: true,
            },
          },
        },
        orderBy: {
          nombre_producto: 'asc',
        },
      });

      const docDefinition = getProductosReport({ productos });
      return this.printerService.createPdf(docDefinition);
    } catch (error) {
      console.error('Error generating PDF:', error);
      throw new Error('Failed to generate PDF report');
    }
  }

  async getCategoriasReportPdfData() {
    try {
      const categorias = await this.prisma.tb_categorias.findMany({
        select: {
          id_categoria: true,
          nombre_cat: true,
          estado: true,
          created_at: true,
          updated_at: true,
        },
      });

      const docDefinition = getCategoriasReport({ categorias });
      return this.printerService.createPdf(docDefinition);
    } catch {
      throw new Error('Failed to generate PDF report');
    }
  }

  async getComprasReporPdf() {
    try {
      const compras = await this.prisma.tb_compra.findMany({
        include: {
          tb_proveedores: {
            select: {
              nombre_comercial: true,
            },
          },
          tb_metodo_pago: {
            select: {
              nombre_metodo_pago: true,
            },
          },
        },
        orderBy: {
          fecha_compra: 'desc',
        },
      });

      const docDefinition = getComprasReport({ compras });
      return this.printerService.createPdf(docDefinition);
    } catch (error) {
      console.error('Error generating PDF:', error);
      throw new Error('Failed to generate PDF report');
    }
  }

  async getProveedoresReportPdf() {
    try {
      const proveedores = await this.prisma.tb_proveedores.findMany({
        include: {
          tb_personas: {
            select: {
              nombres: true,
              apellido_paterno: true,
              apellido_materno: true,
              numero_documento: true,
              correo: true,
              telefono: true,
            },
          },
        },
      });

      const docDefinition = getProveedoresReport({ proveedores });
      return this.printerService.createPdf(docDefinition);
    } catch (error) {
      console.error('Error generating Proveedores PDF:', error);
      throw new Error('Failed to generate Proveedores PDF report');
    }
  }

  async getVentasReportPdf() {
    try {
      const ventas = await this.prisma.tb_ventas.findMany({
        include: {
          tb_cliente: {
            include: {
              tb_personas: {
                select: {
                  nombres: true,
                  apellido_paterno: true,
                  apellido_materno: true,
                  numero_documento: true,
                  correo: true,
                  telefono: true,
                },
              },
            },
          },
          tb_personal: {
            include: {
              tb_personas: {
                select: {
                  nombres: true,
                  apellido_paterno: true,
                  apellido_materno: true,
                  numero_documento: true,
                  correo: true,
                  telefono: true,
                },
              },
            },
          },
          tb_metodo_pago: {
            select: {
              nombre_metodo_pago: true,
            },
          },
        },
        orderBy: {
          fecha_venta: 'desc',
        },
      });

      const docDefinition = getVentasReport({ ventas });
      return this.printerService.createPdf(docDefinition);
    } catch (error) {
      console.error('Error generating Sales PDF:', error);
      throw new Error('Failed to generate Sales PDF report');
    }
  }

  // Método async para generar el PDF de Kardex
  async getKardexReportPdf() {
    try {
      const kardex = await this.prisma.tb_kardex.findMany({
        include: {
          tb_productos: {
            select: {
              nombre_producto: true,
            },
          },
        },
      });

      const docDefinition = getKardexReport({ kardex });
      return this.printerService.createPdf(docDefinition);
    } catch (error) {
      console.error('Error generating Kardex PDF:', error);
      throw new Error('Failed to generate Kardex PDF report');
    }
  }

  // Función del servicio en NestJS
  async getClienteReportPdf() {
    try {
      const clientes = await this.prisma.tb_cliente.findMany({
        include: {
          tb_personas: {
            select: {
              nombres: true,
            },
          },
        },
      });

      const docDefinition = getClienteReport({ clientes });
      return this.printerService.createPdf(docDefinition);
    } catch (error) {
      console.error('Error generating Clientes PDF:', error);
      throw new Error('Failed to generate Clientes PDF report');
    }
  }

  async getPersonalReport() {
    try {
      // 1. Obtener datos de personal con Prisma
      const personal = await this.prisma.tb_personal.findMany({
        select: {
          id_personal: true,
          estado: true,
          id_rol: true,
          // No seleccionamos datos sensibles como email o contraseña
          tb_personas: {
            select: {
              nombres: true,
            },
          },
          tb_rol: {
            select: {
              nombre_rol: true,
            },
          },
        },
        orderBy: {
          tb_personas: {
            nombres: 'asc',
          },
        },
      });

      // 2. Generar el reporte
      const docDefinition = getPersonalReportPdf({ personal });

      // 3. Crear y retornar el PDF
      return this.printerService.createPdf(docDefinition);
    } catch (error) {
      console.error('Error al generar reporte de personal:', error);
      throw new Error('Error al generar el reporte de personal');
    }
  }

  // Función del servicio en NestJS
  async getVentaTicketPdf(idVenta: string) {
    try {
      const venta = await this.prisma.tb_ventas.findUnique({
        where: { id_venta: idVenta },
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
      });

      if (!venta) {
        throw new Error('Venta no encontrada');
      }

      const docDefinition = getVentaTicket({
        venta,
        nombreEmpresa: 'Icase Store',
        direccionEmpresa: 'Av. Grau Puesto 26',
        rucEmpresa: '20123456789',
      });

      return this.printerService.createPdf(docDefinition);
    } catch (error) {
      console.error('Error generating Venta Ticket PDF:', error);
      throw new Error('Failed to generate Venta Ticket PDF');
    }
  }
}
