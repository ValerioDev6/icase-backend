import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { AjustesService } from './ajustes.service';
import { CreateAjusteDto } from './dto/create-ajuste.dto';
import { UpdateAjusteDto } from './dto/update-ajuste.dto';
import { PaginationDto } from 'src/common/dtos/pagination.dto';
import { SkipThrottle } from '@nestjs/throttler';

@SkipThrottle()
@Controller('ajustes')
export class AjustesController {
  constructor(private readonly ajustesService: AjustesService) {}

  @Post()
  create(@Body() createAjusteDto: CreateAjusteDto) {
    return this.ajustesService.create(createAjusteDto);
  }

  @Get()
  findAll(@Query() paginationDto: PaginationDto) {
    return this.ajustesService.findAll(paginationDto);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.ajustesService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateAjusteDto: UpdateAjusteDto) {
    return this.ajustesService.update(+id, updateAjusteDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.ajustesService.remove(id);
  }
}
