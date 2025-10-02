import { Controller, Get } from '@nestjs/common';
import { SkipThrottle } from '@nestjs/throttler';
import { TipoPropietarioService } from './tipo-propietario.service';

@SkipThrottle()
@Controller('tipo-propietario')
export class TipoPropietarioController {
  constructor(private readonly tipoPropietarioService: TipoPropietarioService) {}

  @Get()
  findAll() {
    return this.tipoPropietarioService.findAll();
  }
}
