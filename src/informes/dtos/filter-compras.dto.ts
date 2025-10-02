// filter-ventas.dto.ts
import { Type } from 'class-transformer';
import { IsOptional, IsDateString, IsPositive } from 'class-validator';

export class FilterComprasReportDto {
  @IsOptional()
  @IsPositive()
  @Type(() => Number)
  page?: number;

  @IsOptional()
  @IsPositive()
  @Type(() => Number)
  limit?: number;

  @IsOptional()
  @IsDateString()
  fecha_inicio?: string;

  @IsOptional()
  @IsDateString()
  fecha_fin?: string;
}
