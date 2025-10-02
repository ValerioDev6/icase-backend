import { Controller, Get } from '@nestjs/common';
import { TipoZonaService } from './tipo-zona.service';
import { SkipThrottle } from '@nestjs/throttler';

@SkipThrottle()
@Controller('tipo-zona')
export class TipoZonaController {
  constructor(private readonly tipoZonaService: TipoZonaService) {}

  @Get()
  findAll() {
    return this.tipoZonaService.findAll();
  }
}
