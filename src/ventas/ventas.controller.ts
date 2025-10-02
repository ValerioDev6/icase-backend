import {
  BadRequestException,
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Query,
} from '@nestjs/common';
import { SkipThrottle } from '@nestjs/throttler';
import { tb_personal } from '@prisma/client';
import { Auth } from 'src/auth/decorators/auth.decorator';
import { GetUser } from 'src/auth/decorators/get-user.decorator';
import { PaginationDto } from 'src/common/dtos/pagination.dto';
import { RequestVentaDto } from './dto/create-venta.dto';
import { VentasService } from './ventas.service';

@Auth()
@SkipThrottle()
@Controller('ventas')
export class VentasController {
  constructor(private readonly ventasService: VentasService) {}

  @Post()
  create(@Body() createVentaDto: RequestVentaDto, @GetUser() user: tb_personal) {
    console.log('Usuario recibido:', user);
    if (!user) {
      throw new BadRequestException('Usuario no autenticado');
    }
    return this.ventasService.create(createVentaDto, user);
  }
  @Get()
  findAll(@Query() pagiantionDto: PaginationDto) {
    return this.ventasService.findAll(pagiantionDto);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.ventasService.findOne(id);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.ventasService.remove(+id);
  }

  @Get(':id/detalles')
  findDetallesByCompraId(@Param('id') id: string, @Query() paginationDto: PaginationDto) {
    return this.ventasService.findDetallesByVentaId(id, paginationDto);
  }
}
