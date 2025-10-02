import { CreatePersonalDto } from './create-personal.dto';

export type UpdatePersonalDto = Partial<CreatePersonalDto>;

import { IsOptional, IsString } from 'class-validator';

export class UpdatePersonalDetailDto {
  @IsOptional()
  @IsString()
  nombres?: string;

  @IsOptional()
  @IsString()
  apellido_paterno?: string;

  @IsOptional()
  @IsString()
  apellido_materno?: string;

  @IsOptional()
  @IsString()
  direccion_persona?: string;

  @IsOptional()
  @IsString()
  id_tipo_telefono?: string;

  @IsOptional()
  @IsString()
  telefono?: string;
}
