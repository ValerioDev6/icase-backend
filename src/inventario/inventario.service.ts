import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { CreateInventarioDto } from './dto/create-inventario.dto';
import { UpdateInventarioDto } from './dto/update-inventario.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { Prisma } from '@prisma/client';
import { PaginationDto } from 'src/common/dtos/pagination.dto';

@Injectable()
export class InventarioService {
  constructor(private readonly prisma: PrismaService) {}
  private readonly logger = new Logger('InventarioService');

  async create(createInventarioDto: CreateInventarioDto) {
    try {
      return await this.prisma.$transaction(async (prisma) => {
        // 1. Obtener el producto con su stock actual
        const producto = await prisma.tb_productos.findUnique({
          where: { id_producto: createInventarioDto.id_producto },
        });

        if (!producto) {
          throw new BadRequestException('Producto no encontrado');
        }

        const sucursal = await prisma.tb_sucursales.findUnique({
          where: { id_sucursal: createInventarioDto.id_sucursal },
        });

        if (!sucursal) {
          throw new BadRequestException('Sucursal no encontrada');
        }

        // 2. Usar el stock actual del producto como stock anterior
        const stockAnterior = producto.stock;
        let stockNuevo = stockAnterior;

        // 3. Calcular nuevo stock según tipo de movimiento
        if (createInventarioDto.tipo_movimiento === 'SALIDA') {
          if (stockAnterior < createInventarioDto.cantidad) {
            throw new BadRequestException(
              `Stock insuficiente. Stock actual: ${stockAnterior}, Cantidad solicitada: ${createInventarioDto.cantidad}`,
            );
          }
          stockNuevo = stockAnterior - createInventarioDto.cantidad;
        } else {
          stockNuevo = stockAnterior + createInventarioDto.cantidad;
        }

        // 4. Crear el movimiento de inventario
        const movimiento = await prisma.tb_inventario.create({
          data: {
            id_producto: createInventarioDto.id_producto,
            id_sucursal: createInventarioDto.id_sucursal,
            cantidad: createInventarioDto.cantidad,
            tipo_movimiento: createInventarioDto.tipo_movimiento,
            stock_anterior: stockAnterior, // Ahora usa el stock actual del producto
            stock_nuevo: stockNuevo,
            comentarios:
              createInventarioDto.comentarios ||
              `Movimiento de inventario: ${createInventarioDto.tipo_movimiento}`,
          },
          include: {
            tb_productos: true,
            tb_sucursales: true,
          },
        });

        // 5. Actualizar el stock del producto
        await prisma.tb_productos.update({
          where: { id_producto: createInventarioDto.id_producto },
          data: {
            stock: stockNuevo, // Actualizamos directamente al stock nuevo calculado
          },
        });

        return movimiento;
      });
    } catch (error) {
      this.logger.error(`Error en movimiento de inventario: ${error.message}`);
      if (error instanceof BadRequestException) {
        throw error;
      }
      throw new BadRequestException('Error al procesar el movimiento de inventario');
    }
  }

  async findAll(paginationDto: PaginationDto) {
    const { page = 1, limit = 10, search = '' } = paginationDto;
    try {
      const [inventario, total] = await Promise.all([
        this.prisma.tb_inventario.findMany({
          skip: (page - 1) * limit,
          take: limit,
          orderBy: { fecha_creacion: 'desc' },
          include: {
            tb_productos: true,
            tb_sucursales: true,
          },
          where: {
            OR: [
              {
                tipo_movimiento: search
                  ? search.toUpperCase() === 'ENTRADA'
                    ? 'ENTRADA'
                    : search.toUpperCase() === 'SALIDA'
                      ? 'SALIDA'
                      : undefined
                  : undefined,
              },
              {
                tb_productos: {
                  nombre_producto: {
                    contains: search,
                  },
                },
              },
            ],
          },
        }),
        this.prisma.tb_inventario.count({
          where: {
            OR: [
              {
                tipo_movimiento: search
                  ? search.toUpperCase() === 'ENTRADA'
                    ? 'ENTRADA'
                    : search.toUpperCase() === 'SALIDA'
                      ? 'SALIDA'
                      : undefined
                  : undefined,
              },
              {
                tb_productos: {
                  nombre_producto: {
                    contains: search,
                  },
                },
              },
            ],
          },
        }),
      ]);

      return {
        info: {
          page,
          limit,
          total,
          next: `${process.env.HOST_API}/inventario?page=${page + 1}&limit=${limit}&search=${search}`,
          prev:
            page > 1
              ? `${process.env.HOST_API}/inventario?page=${page - 1}&limit=${limit}&search=${search}`
              : null,
        },
        inventario,
      };
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  async findOne(id: string) {
    try {
      const inventario = await this.prisma.tb_inventario.findUnique({
        where: { id_inventario: id },
        include: {
          tb_productos: true,
          tb_sucursales: true,
        },
      });

      return inventario;
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  async update(id: string, updateInventarioDto: UpdateInventarioDto) {
    try {
      return await this.prisma.tb_inventario.update({
        where: { id_inventario: id },
        data: { ...updateInventarioDto },
        include: {
          tb_productos: true,
          tb_sucursales: true,
        },
      });
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  async remove(id: string) {
    try {
      const inventario = await this.prisma.tb_inventario.findUnique({
        where: { id_inventario: id },
      });

      if (!inventario) {
        throw new NotFoundException(`inventario with id: ${id} not found`);
      }

      await this.prisma.tb_inventario.delete({
        where: { id_inventario: id },
      });

      return {
        status: true,
        message: `Inventario with ID ${id} has been deleted`,
      };
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  private handleExceptions(error: any) {
    this.logger.error(error);

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
