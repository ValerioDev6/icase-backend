import { Controller, Get } from '@nestjs/common';
import { TipoPersonaService } from './tipo-persona.service';
import { SkipThrottle } from '@nestjs/throttler';

@SkipThrottle()
@Controller('tipo-persona')
export class TipoPersonaController {
  constructor(private readonly tipoPersonaService: TipoPersonaService) {}

  @Get()
  findAll() {
    return this.tipoPersonaService.findAllCombo();
  }
}
