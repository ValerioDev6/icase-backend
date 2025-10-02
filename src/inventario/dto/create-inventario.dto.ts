import { tb_inventario } from '@prisma/client';

export type CreateInventarioDto = Omit<tb_inventario, 'id_inventario'>;
