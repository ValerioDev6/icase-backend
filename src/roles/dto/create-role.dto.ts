import { tb_permiso, tb_rol } from '@prisma/client';
export type CreateRoleDto = Omit<tb_rol, 'id_rol'>;
export type CreatePermisoDto = Omit<tb_permiso, 'id_permiso'>;
