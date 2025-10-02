import { Controller, Get } from '@nestjs/common';
import { SkipThrottle } from '@nestjs/throttler';
import { TipoViaService } from './tipo-via.service';

@SkipThrottle()
@Controller('tipo-via')
export class TipoViaController {
  constructor(private readonly tipoViaService: TipoViaService) {}

  @Get()
  findAll() {
    return this.tipoViaService.findAll();
  }
}
