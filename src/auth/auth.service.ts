import { BadRequestException, Inject, Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from 'src/prisma/prisma.service';
import * as bcrypt from 'bcrypt';
import { LoginPersonalDto } from './dto/login-personal.dto';
import { CreatePersonalDto } from './dto/create-personal.dto';
import { JwtPayload } from './interfaces/jwt-payload.interfaces';
import { tb_personal } from '@prisma/client';
import { ConfigService } from '@nestjs/config';
import { ChangePasswordDto } from './dto/change-password.dto';
import { LogService } from 'src/monitoreo/monitoreo.service';
@Injectable()
export class AuthService {
  constructor(
    private readonly configService: ConfigService,
    private readonly prisma: PrismaService,
    private readonly jwtService: JwtService,
    private readonly logger: LogService,
  ) {}

  async login2(loginPersonalDto: LoginPersonalDto) {
    const { email, password } = loginPersonalDto;

    const personal = await this.prisma.tb_personal.findFirst({
      where: { email },
    });

    if (!personal) {
      this.logger.createErrorLog(' Usuario error emai', email);
      throw new UnauthorizedException('Credenciales inválidas');
    }

    const isPasswordValid = await bcrypt.compare(password, personal.contrasenia);

    if (!isPasswordValid) {
      this.logger.createErrorLog(' Usuario error emai', password);
      throw new UnauthorizedException('Credenciales inválidas');
    }

    const { contrasenia, ...user } = personal;
    const payload: JwtPayload = { id: personal.id_personal };

    const token = await this.getJwtToken(payload);

    return {
      personal: user,
      access_token: token,
    };
  }

  async login(loginPersonalDto: LoginPersonalDto) {
    const { email, password } = loginPersonalDto;

    const personal = await this.prisma.tb_personal.findFirst({
      where: { email },
      select: {
        id_personal: true,
        email: true,
        contrasenia: true,
        estado: true,
        personal_img: true,
        id_rol: true,
        tb_personas: {
          select: {
            nombres: true,
            apellido_paterno: true,
            apellido_materno: true,
          },
        },
        tb_rol: {
          select: {
            nombre_rol: true,
            tb_permiso: {
              select: {
                tb_modulo: {
                  select: {
                    nombre_modulo: true,
                  },
                },
                puede_crear: true,
                puede_leer: true,
                puede_actualizar: true,
                puede_eliminar: true,
              },
            },
          },
        },
      },
    });

    if (!personal) {
      this.logger.createErrorLog(' Usuario error email', email);
      throw new UnauthorizedException('Credenciales inválidas');
    }

    const isPasswordValid = await bcrypt.compare(password, personal.contrasenia);
    if (!isPasswordValid) {
      this.logger.createErrorLog(' Usuario error email', password);
      throw new UnauthorizedException('Credenciales inválidas');
    }

    // Transformar los permisos a un formato más simple
    const permissions =
      personal.tb_rol?.tb_permiso.map((permiso) => ({
        modulo: permiso.tb_modulo?.nombre_modulo,
        permisos: {
          crear: Boolean(permiso.puede_crear),
          leer: Boolean(permiso.puede_leer),
          actualizar: Boolean(permiso.puede_actualizar),
          eliminar: Boolean(permiso.puede_eliminar),
        },
      })) || [];

    const { contrasenia, ...user } = personal;
    const payload: JwtPayload = { id: personal.id_personal };
    const token = await this.getJwtToken(payload);

    return {
      personal: {
        ...user,
        rol: personal.tb_rol?.nombre_rol,
        permisos: permissions,
      },
      access_token: token,
    };
  }

  async register(createPersonalDto: CreatePersonalDto) {
    const { contrasenia, ...rest } = createPersonalDto;

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

    return {
      user: nuevoPersonal,
    };
  }

  async checkAuthStatus(user: tb_personal) {
    const { id_personal, email, estado, personal_img, id_rol, id_persona } = user;
    const personaInfo = id_persona
      ? await this.prisma.tb_personas.findUnique({
          where: { id_persona },
          select: {
            nombres: true,
            apellido_paterno: true,
            apellido_materno: true,
            id_persona: true,
          },
        })
      : null;

    const payload: JwtPayload = { id: id_personal };
    const tokens = await this.getJwtToken(payload);

    return {
      id_personal,
      email,
      estado,
      personal_img,
      id_rol,
      persona: personaInfo,
      access_token: tokens,
    };
  }

  // async checkAuthStatus(user: tb_personal) {
  //   const userWithPermissions = await this.prisma.tb_personal.findUnique({
  //     where: {
  //       id_personal: user.id_personal,
  //     },
  //     include: {
  //       tb_personas: {
  //         select: {
  //           nombres: true,
  //           apellido_paterno: true,
  //           apellido_materno: true,
  //           id_persona: true,
  //         },
  //       },
  //       tb_rol: {
  //         include: {
  //           tb_permiso: {
  //             include: {
  //               tb_modulo: true,
  //             },
  //           },
  //         },
  //       },
  //     },
  //   });

  //   if (!userWithPermissions) {
  //     throw new UnauthorizedException('Usuario no encontrado');
  //   }

  //   const permissions =
  //     userWithPermissions.tb_rol?.tb_permiso.map((permiso) => ({
  //       modulo: permiso.tb_modulo?.nombre_modulo,
  //       permisos: {
  //         crear: Boolean(permiso.puede_crear),
  //         leer: Boolean(permiso.puede_leer),
  //         actualizar: Boolean(permiso.puede_actualizar),
  //         eliminar: Boolean(permiso.puede_eliminar),
  //       },
  //     })) || [];

  //   const payload: JwtPayload = { id: user.id_personal };
  //   const tokens = await this.getJwtToken(payload);

  //   return {
  //     id_personal: userWithPermissions.id_personal,
  //     email: userWithPermissions.email,
  //     estado: userWithPermissions.estado,
  //     personal_img: userWithPermissions.personal_img,
  //     id_rol: userWithPermissions.id_rol,
  //     rol: userWithPermissions.tb_rol?.nombre_rol,
  //     persona: userWithPermissions.tb_personas,
  //     permisos: permissions,
  //     access_token: tokens,
  //   };
  // }

  async changePassword(idPersonal: string, changePasswordDto: ChangePasswordDto) {
    const personal = await this.prisma.tb_personal.findUnique({
      where: { id_personal: idPersonal },
    });

    if (!personal) {
      throw new UnauthorizedException('Personal no encontrado');
    }

    const isPasswordValid = await bcrypt.compare(
      changePasswordDto.currentPassword,
      personal.contrasenia,
    );

    if (!isPasswordValid) {
      throw new UnauthorizedException('La contraseña actual es incorrecta');
    }
    if (changePasswordDto.newPassword !== changePasswordDto.confirmNewPassword) {
      throw new UnauthorizedException('La nueva contraseña y la confirmación no coinciden');
    }

    const hashedNewPassword = await bcrypt.hash(changePasswordDto.newPassword, 10);
    await this.prisma.tb_personal.update({
      where: { id_personal: idPersonal },
      data: { contrasenia: hashedNewPassword },
    });

    return {
      ok: true,
      message: 'Contraseña actualizada exitosamente',
    };
  }
  private getJwtToken(payload: JwtPayload) {
    return this.jwtService.sign(payload);
  }
}
