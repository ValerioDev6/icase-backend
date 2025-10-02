import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { APP_GUARD } from '@nestjs/core';
import { ThrottlerModule } from '@nestjs/throttler';
import { GoogleRecaptchaModule, GoogleRecaptchaNetwork } from '@nestlab/google-recaptcha';
import { AjustesModule } from './ajustes/ajustes.module';
import { AuthModule } from './auth/auth.module';
import { CustomThrottlerGuard } from './auth/guards/custom-throttler.guard';
import { CategorieModule } from './categorie/categorie.module';
import { ChatsModule } from './chats/chats.module';
import { ClienteModule } from './cliente/cliente.module';
import { CommonModule } from './common/common.module';
import { ComprasModule } from './compras/compras.module';
import { DireccionModule } from './direccion/direccion.module';
import { InformesModule } from './informes/informes.module';
import { InventarioModule } from './inventario/inventario.module';
import { KardexModule } from './kardex/kardex.module';
import { MarcasModule } from './marcas/marcas.module';
import { MessagesModule } from './messages/messages.module';
import { MetodoPagosModule } from './metodo-pagos/metodo-pagos.module';
import { LogModule } from './monitoreo/monitoreo.module';
import { MovimientosModule } from './movimientos/movimientos.module';
import { PaisModule } from './pais/pais.module';
import { PersonaModule } from './persona/persona.module';
import { PersonalModule } from './personal/personal.module';
import { PrinterModule } from './printer/printer.module';
import { PrismaModule } from './prisma/prima.module';
import { PrismaService } from './prisma/prisma.service';
import { ProductsModule } from './products/products.module';
import { ProveedoresModule } from './proveedores/proveedores.module';
import { BasicReportsExcelModule } from './report-excel/basic-reports-excel.module';
import { ReportHtmlModule } from './report-html/report-html.module';
import { BasicReportsModule } from './reports-pdf/basic-reports.module';
import { RolesModule } from './roles/roles.module';
import { SalesModule } from './sales/sales.module';
import { SexoModule } from './sexo/sexo.module';
import { SurcursalModule } from './surcursal/surcursal.module';
import { TelefonoPersonalModule } from './telefono-personal/telefono-personal.module';
import { TipoDocumentoModule } from './tipo-documento/tipo-documento.module';
import { TipoPersonaModule } from './tipo-persona/tipo-persona.module';
import { TipoPropietarioModule } from './tipo-propietario/tipo-propietario.module';
import { TipoTelefonoModule } from './tipo-telefono/tipo-telefono.module';
import { TipoViaModule } from './tipo-via/tipo-via.module';
import { TipoZonaModule } from './tipo-zona/tipo-zona.module';
import { UploadsExcelModule } from './uploads-excel/uploads-excel.module';
import { VentasModule } from './ventas/ventas.module';

@Module({
  imports: [
    ConfigModule.forRoot(),
    ThrottlerModule.forRoot({
      throttlers: [
        {
          ttl: 6000,
          limit: 3,
        },
      ],
    }),
    GoogleRecaptchaModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        secretKey: configService.get('GOOGLE_RECAPTCHA_SECRET_KEY'),
        response: (req) => req.body.recaptchaToken,
        network: GoogleRecaptchaNetwork.Recaptcha,
      }),
      inject: [ConfigService],
    }),

    CategorieModule,
    AuthModule,
    PersonalModule,
    CommonModule,
    PrismaModule,
    PersonaModule,
    RolesModule,
    ProductsModule,
    TipoPersonaModule,
    SexoModule,
    TipoDocumentoModule,
    PaisModule,
    DireccionModule,
    TelefonoPersonalModule,
    ProveedoresModule,
    ClienteModule,
    MarcasModule,
    SurcursalModule,
    TipoZonaModule,
    TipoViaModule,
    TipoTelefonoModule,
    BasicReportsModule,
    PrinterModule,
    BasicReportsExcelModule,
    TipoPropietarioModule,
    InventarioModule,
    MovimientosModule,
    VentasModule,
    ComprasModule,
    MetodoPagosModule,
    KardexModule,
    ReportHtmlModule,
    SalesModule,
    UploadsExcelModule,
    LogModule,
    InformesModule,
    AjustesModule,
    MessagesModule,
    ChatsModule,
  ],
  controllers: [],
  providers: [
    PrismaService,
    {
      provide: APP_GUARD,
      useClass: CustomThrottlerGuard,
    },
  ],
})
export class AppModule {}
