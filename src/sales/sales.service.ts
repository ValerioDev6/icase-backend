import { Injectable } from '@nestjs/common';
import { Decimal } from '@prisma/client/runtime/library';
import { PrismaService } from 'src/prisma/prisma.service';
export interface RawMonthlyVentas {
  mes: bigint;
  total_ventas: bigint;
  numero_ventas: bigint;
}

export interface MonthlyVentas {
  mes: number;
  total_ventas: number;
  numero_ventas: number;
}
@Injectable()
export class SalesService {
  constructor(private prisma: PrismaService) {}

  async getTotales() {
    const [
      totalProductos,
      totalCategorias,
      totalMarcas,
      totalProveedores,
      totalVentas,
      totalCompras,
      totalUsuarios,
      totalClientes,
      totalSucursales,
    ] = await Promise.all([
      this.prisma.tb_productos.count(),
      this.prisma.tb_categorias.count(),
      this.prisma.tb_marcas.count(),
      this.prisma.tb_proveedores.count(),
      this.prisma.tb_ventas.count(),
      this.prisma.tb_compra.count(),
      this.prisma.tb_personal.count(),
      this.prisma.tb_cliente.count(),
      this.prisma.tb_sucursales.count(),
    ]);

    return {
      totalProductos,
      totalCategorias,
      totalMarcas,
      totalProveedores,
      totalVentas,
      totalCompras,
      totalUsuarios,
      totalClientes,
      totalSucursales,
    };
  }

  async getVentasDiasSemanaMes() {
    try {
      // Consultas utilizando Prisma para obtener ventas
      const ventasHoy = await this.prisma.$queryRaw`
        SELECT 
          COUNT(id_venta) as total_ventas,
          COALESCE(SUM(precio_total), 0) as monto_total
        FROM tb_ventas
        WHERE 
          DATE(created_at) = CURRENT_DATE 
          AND estado_venta = 'COMPLETADA'
      `;

      const ventasSemana = await this.prisma.$queryRaw`
        SELECT 
          COALESCE(SUM(precio_total), 0) as monto_total
        FROM tb_ventas
        WHERE 
          YEARWEEK(created_at) = YEARWEEK(CURRENT_DATE)
          AND estado_venta = 'COMPLETADA'
      `;

      const ventasMes = await this.prisma.$queryRaw`
        SELECT 
          COALESCE(SUM(precio_total), 0) as monto_total
        FROM tb_ventas
        WHERE 
          YEAR(created_at) = YEAR(CURRENT_DATE)
          AND MONTH(created_at) = MONTH(CURRENT_DATE)
          AND estado_venta = 'COMPLETADA'
      `;

      return {
        ventas_hoy: {
          total_ventas: Number(ventasHoy[0]?.total_ventas || 0),
          monto_total: Number(ventasHoy[0]?.monto_total || 0),
        },
        ventas_semana: {
          monto_total: Number(ventasSemana[0]?.monto_total || 0),
        },
        ventas_mes: {
          monto_total: Number(ventasMes[0]?.monto_total || 0),
        },
      };
    } catch (error) {
      console.error('Error en getVentasDiasSemanaMes:', error);
      throw error;
    }
  }
  async obtenerVentasMensuales(): Promise<MonthlyVentas[]> {
    const ventasMensuales = await this.prisma.$queryRaw<RawMonthlyVentas[]>`
      SELECT 
        MONTH(created_at) as mes,
        COALESCE(SUM(precio_total), 0) as total_ventas,
        COUNT(*) as numero_ventas
        FROM 
      tb_ventas
        GROUP BY 
          MONTH(created_at)
        ORDER BY 
          mes
    `;

    const mesesCompletos: MonthlyVentas[] = Array.from({ length: 12 }, (_, i) => {
      const mesExistente = ventasMensuales.find((m) => Number(m.mes) === i + 1);

      return {
        mes: i + 1,
        total_ventas: mesExistente ? Number(mesExistente.total_ventas) : 0,
        numero_ventas: mesExistente ? Number(mesExistente.numero_ventas) : 0,
      };
    });

    return mesesCompletos;
  }

  async obtenerComprasDiezDias() {
    try {
      const fechaActual = new Date();

      const resultados = [];

      for (let i = 0; i < 10; i++) {
        const fecha = new Date(fechaActual);
        fecha.setDate(fechaActual.getDate() - i);

        const inicioDelDia = new Date(fecha);
        inicioDelDia.setHours(0, 0, 0, 0);

        const finDelDia = new Date(fecha);
        finDelDia.setHours(23, 59, 59, 999);

        const totalComprasDia = await this.prisma.tb_compra.aggregate({
          _sum: {
            compra_total: true,
          },
          where: {
            fecha_compra: {
              gte: inicioDelDia,
              lte: finDelDia,
            },
          },
        });

        const dia = fecha.getDate();

        resultados.push({
          dia,
          total: totalComprasDia._sum.compra_total || 0, // Total como número
        });
      }

      return resultados;
    } catch (error) {
      console.error('Error al obtener las compras de los últimos 10 días:', error);
      throw new Error('No se pudieron recuperar las compras');
    }
  }

  async getTopProductos(): Promise<any[]> {
    const topProductos = await this.prisma.tb_detalle_venta.groupBy({
      by: ['id_producto'],
      _sum: {
        cantidad: true,
      },
      orderBy: {
        _sum: {
          cantidad: 'desc',
        },
      },
      take: 5,
    });

    const productosConDetalles = await Promise.all(
      topProductos.map(async (producto) => {
        const detalles = await this.prisma.tb_productos.findUnique({
          where: { id_producto: producto.id_producto },
        });
        return {
          ...producto,
          nombre: detalles?.nombre_producto,
        };
      }),
    );

    return productosConDetalles;
  }

  async alertaProductoStock() {
    try {
      const productosConBajoStock = await this.prisma.tb_productos.findMany({
        where: {
          stock: {
            lte: 1,
          },
          is_active: true,
        },
        select: {
          id_producto: true,
          nombre_producto: true,
          stock: true,
        },
      });

      const alertas = productosConBajoStock.map((producto) => ({
        id: producto.id_producto,
        nombre: producto.nombre_producto,
        stock: producto.stock,
        mensaje: `Alerta de stock bajo: ${producto.nombre_producto} tiene solo ${producto.stock} unidades disponibles`,
      }));

      return {
        totalProductosBajoStock: alertas.length,
        alertas,
      };
    } catch (error) {
      // Manejo de errores
      throw new Error(`Error al obtener alertas de stock: ${error.message}`);
    }
  }

  async ventaAlAnio() {
    const currentYear = new Date().getFullYear();

    const ventasPorMes = await this.prisma.tb_ventas.groupBy({
      by: ['created_at'],
      where: {
        created_at: {
          gte: new Date(`${currentYear}-01-01`),
          lte: new Date(`${currentYear}-12-31`),
        },
        estado_venta: 'COMPLETADA',
      },
      _sum: {
        precio_total: true,
      },
      orderBy: {
        created_at: 'asc',
      },
    });

    // Transformar resultados a un formato más legible
    const resumenVentas = {
      anio: currentYear,
      totalAnual: new Decimal(0),
      ventasPorMes: Array(12)
        .fill(0)
        .map((_, index) => ({
          mes: index + 1,
          total: new Decimal(0),
        })),
    };

    ventasPorMes.forEach((venta) => {
      if (venta.created_at) {
        const mes = venta.created_at.getMonth();
        const montoVenta = venta._sum.precio_total || new Decimal(0);

        // Usar métodos de Decimal para suma
        resumenVentas.ventasPorMes[mes].total =
          resumenVentas.ventasPorMes[mes].total.plus(montoVenta);
        resumenVentas.totalAnual = resumenVentas.totalAnual.plus(montoVenta);
      }
    });

    return resumenVentas;
  }

  async comprasAlAnio() {
    const currentYear = new Date().getFullYear();

    const comprasPorMes = await this.prisma.tb_compra.groupBy({
      by: ['fecha_compra'],
      where: {
        fecha_compra: {
          gte: new Date(`${currentYear}-01-01`),
          lte: new Date(`${currentYear}-12-31`),
        },
      },
      _sum: {
        compra_total: true,
      },
      orderBy: {
        fecha_compra: 'asc',
      },
    });

    // Transformar resultados a un formato más legible
    const resumenCompras = {
      anio: currentYear,
      totalAnual: new Decimal(0),
      comprasPorMes: Array(12)
        .fill(0)
        .map((_, index) => ({
          mes: index + 1,
          total: new Decimal(0),
        })),
    };

    comprasPorMes.forEach((compra) => {
      if (compra.fecha_compra) {
        const mes = compra.fecha_compra.getMonth();
        const montoCompra = compra._sum.compra_total || new Decimal(0);

        // Usar métodos de Decimal para suma
        resumenCompras.comprasPorMes[mes].total =
          resumenCompras.comprasPorMes[mes].total.plus(montoCompra);
        resumenCompras.totalAnual = resumenCompras.totalAnual.plus(montoCompra);
      }
    });

    return resumenCompras;
  }
}
