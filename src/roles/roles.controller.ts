import { Controller, Get, Post, Body, Patch, Param, Delete, Query } from '@nestjs/common';
import { RolesService } from './roles.service';
import { CreatePermisoDto, CreateRoleDto } from './dto/create-role.dto';
import { UpdatePermisoDto, UpdateRoleDto } from './dto/update-role.dto';
import { PaginationDto } from 'src/common/dtos/pagination.dto';
import { Auth } from 'src/auth/decorators/auth.decorator';
import { SkipThrottle } from '@nestjs/throttler';

// @Auth()
@SkipThrottle()
@Controller('roles')
export class RolesController {
  constructor(private readonly rolesService: RolesService) {}

  @Post()
  create(@Body() createRoleDto: CreateRoleDto) {
    return this.rolesService.create(createRoleDto);
  }

  @Post('permisos')
  createPermiso(@Body() createPermisoDto: CreatePermisoDto) {
    return this.rolesService.createPermiso(createPermisoDto);
  }

  @Get()
  findAll(@Query() paginationDto: PaginationDto) {
    return this.rolesService.findAll(paginationDto);
  }

  @Get('combo')
  findAllRolCombo() {
    return this.rolesService.findAllCombo();
  }

  @Get('combo/modulos')
  findAllModulos() {
    return this.rolesService.findAllComboModulos();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.rolesService.findOne(id);
  }

  @Get(':id/permiso')
  findOnePermiso(@Param('id') id: string) {
    return this.rolesService.finOnePermiso(id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateRoleDto: UpdateRoleDto) {
    return this.rolesService.update(id, updateRoleDto);
  }
  @Patch(':id/permiso')
  updatePermisos(@Param('id') id: string, @Body() updatePermisosDto: UpdatePermisoDto) {
    return this.rolesService.updatePermiso(id, updatePermisosDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.rolesService.remove(id);
  }

  @Delete(':id/permiso')
  removePermisos(@Param('id') id: string) {
    return this.rolesService.removePermiso(id);
  }
}
