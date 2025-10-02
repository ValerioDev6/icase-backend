import { tb_encuesta, tb_personal } from '@prisma/client';
export type CreatePersonalDto = Omit<tb_personal, 'id_personal'>;
export type CreateEncuestaDto = Omit<tb_encuesta, 'id_encuesta'>;
