import {
  BadRequestException,
  HttpException,
  Injectable,
  InternalServerErrorException,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { CreatePaiDto } from './dto/create-pai.dto';
import { UpdatePaiDto } from './dto/update-pai.dto';
import { PaginationDto } from '../common/dtos/pagination.dto';
import { PrismaService } from 'src/prisma/prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class PaisService {
  constructor(private readonly prisma: PrismaService) {}
  private readonly logger = new Logger('PaisService');
  create(createPaiDto: CreatePaiDto) {
    return 'This action adds a new pai';
  }

  async findAll() {
    try {
      const pais = await this.prisma.tb_pais.findMany({
        orderBy: {
          nombre: 'asc',
        },
      });

      return pais;
    } catch (error) {
      this.handleExceptions(error);
    }
  }
  findOne(id: number) {
    return `This action returns a #${id} pai`;
  }

  update(id: number, updatePaiDto: UpdatePaiDto) {
    return `This action updates a #${id} pai`;
  }

  remove(id: number) {
    return `This action removes a #${id} pai`;
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
