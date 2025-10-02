import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { SalesService } from './sales.service';
import { Auth } from 'src/auth/decorators/auth.decorator';
import { SkipThrottle } from '@nestjs/throttler';

@SkipThrottle()
@Auth()
@Controller('sales')
export class SalesController {
  constructor(private readonly salesService: SalesService) {}

  @Get()
  findAll() {
    return this.salesService.getTotales();
  }
  @Get('consulta-mes-semana')
  findAllMesSemanaMes() {
    return this.salesService.getVentasDiasSemanaMes();
  }

  @Get('consulta-mes')
  findAllMes() {
    return this.salesService.obtenerVentasMensuales();
  }

  @Get('consulta-compra-dias')
  findAllCompras() {
    return this.salesService.obtenerComprasDiezDias();
  }
  @Get('consulta-articulos')
  findAllArticulos() {
    return this.salesService.getTopProductos();
  }

  @Get('consulta-alerta')
  findAlertaProducto() {
    return this.salesService.alertaProductoStock();
  }

  @Get('ventas-totales')
  findAlVentasAnuales() {
    return this.salesService.ventaAlAnio();
  }
  @Get('compras-totales')
  findAlComprasAnuales() {
    return this.salesService.comprasAlAnio();
  }
}
