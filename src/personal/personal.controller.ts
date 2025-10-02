import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { PersonalService } from './personal.service';
import { CreateEncuestaDto, CreatePersonalDto } from './dto/create-personal.dto';
import { UpdatePersonalDetailDto, UpdatePersonalDto } from './dto/update-personal.dto';
import { PaginationDto } from 'src/common/dtos/pagination.dto';
import { SkipThrottle } from '@nestjs/throttler';
@SkipThrottle()
@Controller('personal')
export class PersonalController {
  constructor(private readonly personalService: PersonalService) {}

  @Post()
  create(@Body() createPersonalDto: CreatePersonalDto) {
    return this.personalService.create(createPersonalDto);
  }

  @Post(':id/encuesta')
  createEncuesta(@Param('id') id: string, @Body() createEncuestaDto: CreateEncuestaDto) {
    return this.personalService.createEncuesta(id, createEncuestaDto);
  }
  @Get()
  findAll(@Query() paginationDto: PaginationDto) {
    return this.personalService.findAll(paginationDto);
  }

  @Get('encuesta')
  findAllEncuestaPersonal(@Query() paginationDto: PaginationDto) {
    return this.personalService.findAllEncuestas(paginationDto);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.personalService.findOne(id);
  }

  @Get(':id/detalle')
  findOneDetalle(@Param('id') id: string) {
    return this.personalService.findOneAll(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updatePersonalDto: UpdatePersonalDetailDto) {
    return this.personalService.update(id, updatePersonalDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.personalService.remove(id);
  }
}
