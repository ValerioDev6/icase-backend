import {
  BadRequestException,
  HttpException,
  Injectable,
  InternalServerErrorException,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { FilterKardexDto } from 'src/common/dtos/pagination-kardex.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateKardexDto } from './dto/create-kardex.dto';
import { UpdateKardexDto } from './dto/update-kardex.dto';

@Injectable()
export class KardexService {
  constructor(private readonly prisma: PrismaService) {}
  private readonly logger = new Logger('KardexService');
  create(createKardexDto: CreateKardexDto) {
    return 'This action adds a new kardex';
  }

  async getAll(filterDto: FilterKardexDto) {
    const {
      tipo_documento,
      tipo_movimiento,
      fecha_inicio,
      fecha_fin,
      page = 1,
      limit = 10,
    } = filterDto;

    const filters: any = {};

    if (tipo_documento) {
      filters.tipo_documento = tipo_documento;
    }

    if (tipo_movimiento) {
      filters.tipo_movimiento = tipo_movimiento;
    }

    if (fecha_inicio && fecha_fin) {
      filters.fecha_movimiento = {
        gte: new Date(fecha_inicio),
        lte: new Date(fecha_fin),
      };
    }

    const [kardex, total] = await Promise.all([
      this.prisma.tb_kardex.findMany({
        skip: (page - 1) * limit,
        take: limit,
        where: filters,
        include: {
          tb_productos: true,
        },
        orderBy: { fecha_movimiento: 'desc' },
      }),
      this.prisma.tb_kardex.count({ where: filters }),
    ]);

    return {
      info: {
        page,
        limit,
        total,
        next: `${process.env.HOST_API}/kardex?page=${page + 1}&limit=${limit}`,
        prev: page > 1 ? `${process.env.HOST_API}/kardex?page=${page - 1}&limit=${limit}` : null,
      },
      kardex,
    };
  }

  findOne(id: number) {
    return `This action returns a #${id} kardex`;
  }

  update(id: number, updateKardexDto: UpdateKardexDto) {
    return `This action updates a #${id} kardex`;
  }

  remove(id: number) {
    return `This action removes a #${id} kardex`;
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
