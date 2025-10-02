import { tb_ajuste_inventario } from '@prisma/client';

export type CreateAjusteDto = Omit<tb_ajuste_inventario, 'id_ajuste'>;

// import { IsNotEmpty, IsString, IsInt, IsUUID, IsOptional, IsIn } from 'class-validator';

// export class CreateAjusteDto {
//   @IsNotEmpty()
//   @IsString()
//   razon_ajuste: string;

//   @IsNotEmpty()
//   @IsInt()
//   cantidad_ajuste: number;

//   @IsNotEmpty()
//   @IsUUID()
//   id_producto: string;

//   @IsNotEmpty()
//   @IsString()
//   @IsIn(['INCREMENTO', 'DISMINUCION'])
//   tipo_ajuste: 'INCREMENTO' | 'DISMINUCION';

//   @IsOptional()
//   @IsString()
//   nota?: string;
// }
