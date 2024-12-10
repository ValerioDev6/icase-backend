import { Type } from 'class-transformer';
import { IsOptional, IsEnum, IsDateString, IsPositive } from 'class-validator';

export class FilterKardexDto {
  @IsOptional()
  @IsPositive()
  @Type(() => Number)
  page?: number;

  @IsOptional()
  @IsPositive()
  @Type(() => Number)
  limit?: number;

  @IsOptional()
  @IsEnum(['COMPRA', 'VENTA'])
  tipo_documento?: 'COMPRA' | 'VENTA';

  @IsOptional()
  @IsEnum(['ENTRADA', 'SALIDA'])
  tipo_movimiento?: 'ENTRADA' | 'SALIDA';

  @IsOptional()
  @IsDateString()
  fecha_inicio?: string;

  @IsOptional()
  @IsDateString()
  fecha_fin?: string;
}
