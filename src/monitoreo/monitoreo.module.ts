import { Module } from '@nestjs/common';
import { LogService } from './monitoreo.service';

@Module({
  providers: [LogService],
  exports: [LogService], // Exportar si se usará en otros módulos
})
export class LogModule {}
