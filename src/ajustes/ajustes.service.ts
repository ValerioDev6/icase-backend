import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { CreateAjusteDto } from './dto/create-ajuste.dto';
import { UpdateAjusteDto } from './dto/update-ajuste.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { Prisma } from '@prisma/client';
import { PaginationDto } from 'src/common/dtos/pagination.dto';

@Injectable()
export class AjustesService {
  private readonly logger = new Logger('AjustesService');
  constructor(private readonly prisma: PrismaService) {}
  // async create(createAjusteDto: CreateAjusteDto) {
  //   try {
  //     const newRazonAjuste = await this.prisma.tb_ajuste_inventario.create({
  //       data: { ...createAjusteDto },
  //       include: {
  //         tb_productos: true,
  //       },
  //     });

  //     return newRazonAjuste;
  //   } catch (error) {
  //     this.handleExceptions(error);
  //   }
  // }
  async create(createAjusteDto: CreateAjusteDto) {
    try {
      return await this.prisma.$transaction(async (prisma) => {
        // 1. Buscar el producto
        const producto = await prisma.tb_productos.findUnique({
          where: { id_producto: createAjusteDto.id_producto },
        });

        if (!producto) {
          throw new BadRequestException('Producto no encontrado');
        }

        const stockAnterior = producto.stock;
        let stockNuevo = 0;

        // 2. Calcular nuevo stock según tipo de ajuste
        if (createAjusteDto.tipo_ajuste === 'DISMINUCION') {
          if (stockAnterior < createAjusteDto.cantidad_ajuste) {
            throw new BadRequestException(
              `No hay suficiente stock. Stock actual: ${stockAnterior}, Cantidad a disminuir: ${createAjusteDto.cantidad_ajuste}`,
            );
          }
          stockNuevo = stockAnterior - createAjusteDto.cantidad_ajuste;
        } else {
          stockNuevo = stockAnterior + createAjusteDto.cantidad_ajuste;
        }

        // 3. Crear el ajuste de inventario
        const ajuste = await prisma.tb_ajuste_inventario.create({
          data: {
            razon_ajuste: createAjusteDto.razon_ajuste,
            cantidad_ajuste: createAjusteDto.cantidad_ajuste,
            stock_anterior: stockAnterior,
            stock_nuevo: stockNuevo,
            id_producto: createAjusteDto.id_producto,
            tipo_ajuste: createAjusteDto.tipo_ajuste,
            nota: createAjusteDto.nota || `Ajuste de inventario: ${createAjusteDto.tipo_ajuste}`,
          },
          include: {
            tb_productos: true,
          },
        });

        // 4. Actualizar el stock del producto
        await prisma.tb_productos.update({
          where: { id_producto: createAjusteDto.id_producto },
          data: { stock: stockNuevo },
        });

        return ajuste;
      });
    } catch (error) {
      this.logger.error(`Error en ajuste de inventario: ${error.message}`);
      if (error instanceof BadRequestException) {
        throw error;
      }
      throw new BadRequestException('Error al procesar el ajuste de inventario');
    }
  }

  async findAll(paginationDto: PaginationDto) {
    const { page = 1, limit = 5, search = '' } = paginationDto;
    try {
      const [ajustes, total] = await Promise.all([
        this.prisma.tb_ajuste_inventario.findMany({
          skip: (page - 1) * limit,
          take: limit,
          orderBy: { fecha_ajuste: 'desc' },
          include: {
            tb_productos: true,
          },
          where: {
            OR: [
              {
                tipo_ajuste: search
                  ? search.toUpperCase() === 'INCREMENTO'
                    ? 'INCREMENTO'
                    : search.toUpperCase() === 'DISMINUCION'
                      ? 'DISMINUCION'
                      : undefined
                  : undefined,
              },
              {
                razon_ajuste: {
                  contains: search,
                },
              },
              {
                nota: {
                  contains: search,
                },
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
        this.prisma.tb_ajuste_inventario.count({
          where: {
            OR: [
              {
                tipo_ajuste: search
                  ? search.toUpperCase() === 'INCREMENTO'
                    ? 'INCREMENTO'
                    : search.toUpperCase() === 'DISMINUCION'
                      ? 'DISMINUCION'
                      : undefined
                  : undefined,
              },
              {
                razon_ajuste: {
                  contains: search,
                },
              },
              {
                nota: {
                  contains: search,
                },
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
          next: `${process.env.HOST_API}/ajustes?page=${page + 1}&limit=${limit}&search=${search}`,
          prev:
            page > 1
              ? `${process.env.HOST_API}/ajustes?page=${page - 1}&limit=${limit}&search=${search}`
              : null,
        },
        ajustes: ajustes,
      };
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  findOne(id: number) {
    return `This action returns a #${id} ajuste`;
  }

  update(id: number, updateAjusteDto: UpdateAjusteDto) {
    return `This action updates a #${id} ajuste`;
  }

  async remove(id: string) {
    try {
      const ajuste = await this.prisma.tb_ajuste_inventario.findUnique({
        where: { id_ajuste: id },
      });

      if (!ajuste) {
        throw new NotFoundException(`Ajuste de Inventario with id  : ${id} not foun`);
      }

      await this.prisma.tb_ajuste_inventario.delete({
        where: { id_ajuste: id },
      });

      return {
        status: true,
        message: `Ajuste with ID: ${id} has been deleted`,
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
