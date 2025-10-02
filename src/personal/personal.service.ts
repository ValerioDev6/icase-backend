import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  Logger,
  NotFoundException,
} from '@nestjs/common';
import { CreateEncuestaDto, CreatePersonalDto } from './dto/create-personal.dto';
import { UpdatePersonalDetailDto, UpdatePersonalDto } from './dto/update-personal.dto';
import { PaginationDto } from 'src/common/dtos/pagination.dto';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import * as bcrypt from 'bcrypt';

@Injectable()
export class PersonalService {
  constructor(private readonly prisma: PrismaService) {}
  private readonly logger = new Logger('PersonalService');

  async create(createPersonalDto: CreatePersonalDto) {
    const { contrasenia, ...rest } = createPersonalDto;

    try {
      const personalExiste = await this.prisma.tb_personal.findFirst({
        where: { email: rest.email },
        select: { id_personal: true },
      });

      if (personalExiste) {
        throw new BadRequestException('Ya existe un personal con este email');
      }

      const hashedPassword = await bcrypt.hash(contrasenia, 10);
      const nuevoPersonal = await this.prisma.tb_personal.create({
        data: {
          ...rest,
          contrasenia: hashedPassword,
        },
        select: {
          id_personal: true,
          email: true,
          estado: true,
          personal_img: true,
          tb_personas: {
            select: {
              id_persona: true,
              nombres: true,
              apellido_paterno: true,
              apellido_materno: true,
              fecha_nacimiento: true,
            },
          },
          tb_rol: {
            select: {
              id_rol: true,
              nombre_rol: true,
            },
          },
        },
      });

      return nuevoPersonal;
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  async findAll(paginationDto: PaginationDto) {
    const { page = 1, limit = 10, search = '' } = paginationDto;

    try {
      const [personal, total] = await Promise.all([
        this.prisma.tb_personal.findMany({
          skip: (page - 1) * limit,
          take: limit,
          orderBy: { email: 'asc' },
          where: {
            tb_personas: {
              nombres: {
                contains: search,
              },
            },
          },
          include: {
            tb_personas: true,
            tb_rol: true,
          },
        }),
        this.prisma.tb_personal.count({
          where: {
            tb_personas: {
              nombres: {
                contains: search,
              },
            },
          },
        }),
      ]);

      return {
        info: {
          page,
          limit,
          total,
          next: `${process.env.HOST_API}/personal?page=${page + 1}&limit=${limit}&search=${search}`,
          prev:
            page > 1
              ? `${process.env.HOST_API}/personal?page=${page - 1}&limit=${limit}&search=${search}`
              : null,
        },
        personal,
      };
    } catch (error) {
      this.handleExceptions(error);
    }
  }
  async findAllEncuestas(paginationDto: PaginationDto) {
    const { page = 1, limit = 10, search = '' } = paginationDto; // Quitamos el filtro de búsqueda

    try {
      const [encuestas, total] = await Promise.all([
        this.prisma.tb_encuesta.findMany({
          skip: (page - 1) * limit,
          take: limit,
          orderBy: { fecha: 'desc' }, // Ordenar por fecha de la encuesta (descendente)
          include: {
            tb_personal: {
              include: {
                tb_personas: true, // Incluir los datos de la persona asociada al personal
              },
            },
          },
        }),
        this.prisma.tb_encuesta.count(), // Contamos el total de encuestas sin el filtro de búsqueda
      ]);

      return {
        info: {
          page,
          limit,
          total,
          next: `${process.env.HOST_API}/personal?page=${page + 1}&limit=${limit}&search=${search}`,
          prev:
            page > 1
              ? `${process.env.HOST_API}/personal?page=${page - 1}&limit=${limit}&search=${search}`
              : null,
        },
        encuestas,
      };
    } catch (error) {
      this.handleExceptions(error); // Manejo de excepciones
    }
  }

  async findOne(id: string) {
    try {
      const personal = await this.prisma.tb_personal.findUnique({
        where: { id_personal: id },
        include: {
          tb_personas: {
            include: {
              tb_pais: true,
              tb_tipo_telefono: true,
              tb_sexo: true,
              tb_direccion: true,
              tb_tipo_persona: true,
              tb_tipo_documento: true,
              tb_telefonos_persona: true,
            },
          },
          tb_rol: true,
        },
      });

      if (!personal) throw new NotFoundException(`Personal con ID ${id} no encontrado`);

      return personal;
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  async update(personalId: string, updateDto: UpdatePersonalDetailDto) {
    const personal = await this.prisma.tb_personal.findUnique({
      where: { id_personal: personalId },
      select: { id_persona: true },
    });

    if (!personal) {
      throw new NotFoundException('Personal record not found');
    }

    await this.prisma.tb_personas.update({
      where: { id_persona: personal.id_persona },
      data: {
        nombres: updateDto.nombres,
        apellido_paterno: updateDto.apellido_paterno,
        apellido_materno: updateDto.apellido_materno,
        direccion_persona: updateDto.direccion_persona,
        id_tipo_telefono: updateDto.id_tipo_telefono,
        telefono: updateDto.telefono,
      },
    });

    // Retorna un mensaje de éxito
    return {
      message: 'Actualización realizada con éxito',
      success: true,
    };
  }

  async findOneAll(id: string) {
    try {
      const personal = await this.prisma.tb_personal.findUnique({
        where: { id_personal: id },
        include: {
          tb_personas: {
            include: {
              tb_pais: true,
              tb_tipo_telefono: true,
              tb_sexo: true,
              tb_direccion: true,
              tb_tipo_persona: true,
              tb_tipo_documento: true,
              tb_telefonos_persona: true,
            },
          },
          tb_rol: true,
          tb_ventas: {
            include: {
              // You can include related entities for sales if needed
              tb_cliente: {
                include: {
                  tb_personas: true,
                },
              },
              tb_metodo_pago: true,
              tb_sucursales: true,
            },
            orderBy: {
              fecha_venta: 'desc', // Optional: order sales by date descending
            },
          },
        },
      });

      if (!personal) throw new NotFoundException(`Personal con ID ${id} no encontrado`);

      return personal;
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  // update(id: string, updatePersonalDto: UpdatePersonalDto) {
  //   return `This action updates a #${id} personal`;
  // }

  async remove(id: string) {
    try {
      const personal = await this.findOne(id);
      await this.prisma.tb_personal.delete({
        where: { id_personal: id },
      });
      if (!personal) {
        throw new NotFoundException(`Personal with Id ${id} not found`);
      }
      return { message: `Personal con ID ${id} eliminado correctamente` };
    } catch (error) {
      this.handleExceptions(error);
    }
  }

  async validatePersonal(idPersonal: string) {
    const personal = await this.prisma.tb_personal.findUnique({
      where: { id_personal: idPersonal },
      select: { id_personal: true },
    });

    if (!personal) {
      throw new NotFoundException('Personal record not found');
    }

    return personal;
  }

  async createEncuesta(idPersonal: string, createEncuestaDto: CreateEncuestaDto) {
    try {
      await this.validatePersonal(idPersonal);

      const encuesta = this.prisma.tb_encuesta.create({
        data: {
          id_personal: idPersonal,
          ...createEncuestaDto,
          fecha: new Date(),
        },
      });
      return encuesta;
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
