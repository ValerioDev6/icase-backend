
model error_log {
  id            Int       @id @default(autoincrement())
  error_message String?   @db.Text
  fecha         DateTime? @db.DateTime(0)
}

model tb_categorias {
  id_categoria      String              @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  nombre_cat        String              @unique(map: "nombre_cat_UNIQUE") @db.VarChar(100)
  estado            Boolean
  created_at        DateTime?           @default(now()) @db.Timestamp(0)
  updated_at        DateTime?           @default(now()) @db.Timestamp(0)
  tb_detalle_compra tb_detalle_compra[]
  tb_productos      tb_productos[]
}

model tb_cliente {
  id_cliente     String                    @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  id_persona     String?                   @db.VarChar(36)
  estado         Boolean?                  @default(true)
  fecha_registro DateTime?                 @default(now()) @db.DateTime(0)
  tipo_cliente   tb_cliente_tipo_cliente?  @default(CASUAL)
  clasificacion  tb_cliente_clasificacion? @default(C)
  ultima_compra  DateTime?                 @db.Date
  total_compras  Decimal?                  @default(0.00) @db.Decimal(10, 2)
  observaciones  String?                   @db.Text
  codigo_cliente String?                   @unique(map: "codigo_cliente") @db.VarChar(10)
  tb_personas    tb_personas?              @relation(fields: [id_persona], references: [id_persona], onDelete: NoAction, onUpdate: NoAction, map: "tb_cliente_ibfk_1")
  tb_pedidos     tb_pedidos[]
  tb_ventas      tb_ventas[]

  @@index([id_persona], map: "id_persona")
}

model tb_compra {
  id_compra         String              @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  id_metodo_pago    String?             @db.VarChar(36)
  proveedor_id      String?             @db.VarChar(36)
  proveedor_ruc     String?             @db.VarChar(15)
  proveedor_correo  String?             @db.VarChar(100)
  numero_documento  String?             @db.VarChar(20)
  compra_subtotal   Decimal?            @db.Decimal(10, 2)
  compra_igv        Decimal?            @db.Decimal(10, 2)
  compra_total      Decimal?            @db.Decimal(10, 2)
  compra_comentario String?             @db.Text
  fecha_compra      DateTime?           @default(now()) @db.Timestamp(0)
  tb_metodo_pago    tb_metodo_pago?     @relation(fields: [id_metodo_pago], references: [id_metodo_pago], onDelete: NoAction, onUpdate: NoAction, map: "tb_compra_ibfk_1")
  tb_proveedores    tb_proveedores?     @relation(fields: [proveedor_id], references: [id_proveedor], onDelete: NoAction, onUpdate: NoAction, map: "tb_compra_ibfk_2")
  tb_detalle_compra tb_detalle_compra[]

  @@index([id_metodo_pago], map: "id_metodo_pago")
  @@index([proveedor_id], map: "proveedor_id")
}

model tb_detalle_compra {
  id_detalle_compra String         @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  id_compra         String?        @db.VarChar(36)
  id_producto       String?        @db.VarChar(36)
  id_categoria      String?        @db.VarChar(36)
  cantidad          Int?
  precio_unitario   Decimal?       @db.Decimal(10, 2)
  subtotal          Decimal?       @db.Decimal(10, 2)
  fecha_compra      DateTime?      @default(now()) @db.DateTime(0)
  created_at        DateTime?      @default(now()) @db.Timestamp(0)
  tb_compra         tb_compra?     @relation(fields: [id_compra], references: [id_compra], onDelete: NoAction, onUpdate: NoAction, map: "tb_detalle_compra_ibfk_1")
  tb_productos      tb_productos?  @relation(fields: [id_producto], references: [id_producto], onDelete: NoAction, onUpdate: NoAction, map: "tb_detalle_compra_ibfk_2")
  tb_categorias     tb_categorias? @relation(fields: [id_categoria], references: [id_categoria], onDelete: NoAction, onUpdate: NoAction, map: "tb_detalle_compra_ibfk_3")

  @@index([id_categoria], map: "id_categoria")
  @@index([id_compra], map: "id_compra")
  @@index([id_producto], map: "id_producto")
}


model tb_detalle_pedido {
  id_detalle_pedido String        @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  id_pedido         String?       @db.VarChar(36)
  id_producto       String?       @db.VarChar(36)
  cantidad          Int
  precio_unitario   Decimal?      @db.Decimal(10, 2)
  subtotal          Decimal?      @db.Decimal(10, 2)
  tb_pedidos        tb_pedidos?   @relation(fields: [id_pedido], references: [id_pedido], onDelete: NoAction, onUpdate: NoAction, map: "tb_detalle_pedido_ibfk_1")
  tb_productos      tb_productos? @relation(fields: [id_producto], references: [id_producto], onDelete: NoAction, onUpdate: NoAction, map: "tb_detalle_pedido_ibfk_2")

  @@index([id_pedido], map: "id_pedido")
  @@index([id_producto], map: "id_producto")
}

model tb_detalle_venta {
  id_detalle_venta String        @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  id_venta         String?       @db.VarChar(36)
  id_producto      String?       @db.VarChar(36)
  cantidad         Int
  precio_unitario  Decimal       @db.Decimal(10, 2)
  subtotal         Decimal       @db.Decimal(10, 2)
  precio           Decimal?      @db.Decimal(10, 2)
  descuento        Decimal?      @db.Decimal(10, 2)
  created_at       DateTime?     @default(now()) @db.Timestamp(0)
  tb_productos     tb_productos? @relation(fields: [id_producto], references: [id_producto], onDelete: NoAction, onUpdate: NoAction, map: "tb_detalle_venta_ibfk_1")
  tb_ventas        tb_ventas?    @relation(fields: [id_venta], references: [id_venta], onDelete: NoAction, onUpdate: NoAction, map: "tb_detalle_venta_ibfk_2")

  @@index([id_producto], map: "id_producto")
  @@index([id_venta], map: "id_venta")
}

model tb_devoluciones {
  id_devoluciones   String     @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  id_venta          String?    @db.VarChar(36)
  tipo_persona      String?    @db.VarChar(100)
  fecha_devolucion  DateTime?  @db.Date
  motivo_devolucion String?    @db.VarChar(200)
  nota_adicional    String?    @db.Text
  tb_ventas         tb_ventas? @relation(fields: [id_venta], references: [id_venta], onDelete: NoAction, onUpdate: NoAction, map: "tb_devoluciones_ibfk_1")

  @@index([id_venta], map: "id_venta")
}

model tb_direccion {
  id_direccion  String          @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  direccion     String          @db.VarChar(200)
  id_tipo_via   String?         @db.VarChar(36)
  id_tipo_zona  String?         @db.VarChar(36)
  tb_tipo_via   tb_tipo_via?    @relation(fields: [id_tipo_via], references: [id_tipo_via], onDelete: NoAction, onUpdate: NoAction, map: "tb_direccion_ibfk_1")
  tb_tipo_zona  tb_tipo_zona?   @relation(fields: [id_tipo_zona], references: [id_tipo_zona], onDelete: NoAction, onUpdate: NoAction, map: "tb_direccion_ibfk_2")
  tb_personas   tb_personas[]
  tb_sucursales tb_sucursales[]

  @@index([id_tipo_via], map: "id_tipo_via")
  @@index([id_tipo_zona], map: "id_tipo_zona")
}

model tb_inventario {
  id_inventario String         @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  id_producto   String?        @db.VarChar(36)
  id_sucursal   String?        @db.VarChar(36)
  cantidad      Int
  ubicacion     String?        @db.VarChar(100)
  tb_productos  tb_productos?  @relation(fields: [id_producto], references: [id_producto], onDelete: NoAction, onUpdate: NoAction, map: "tb_inventario_ibfk_1")
  tb_sucursales tb_sucursales? @relation(fields: [id_sucursal], references: [id_sucursal], onDelete: NoAction, onUpdate: NoAction, map: "tb_inventario_ibfk_2")

  @@index([id_producto], map: "id_producto")
  @@index([id_sucursal], map: "id_sucursal")
}

model tb_kardex {
  id_kardex        String                     @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  id_producto      String?                    @db.VarChar(36)
  fecha_movimiento DateTime?                  @default(now()) @db.Timestamp(0)
  tipo_movimiento  tb_kardex_tipo_movimiento?
  tipo_documento   tb_kardex_tipo_documento?
  numero_documento String?                    @db.VarChar(20)
  cantidad         Int?
  precio_unitario  Decimal?                   @db.Decimal(10, 2)
  total            Decimal?                   @db.Decimal(10, 2)
  stock_anterior   Int?
  stock_actual     Int?
  tb_productos     tb_productos?              @relation(fields: [id_producto], references: [id_producto], onDelete: NoAction, onUpdate: NoAction, map: "tb_kardex_ibfk_1")

  @@index([id_producto], map: "id_producto")
}

model tb_marcas {
  id_marca     String         @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  nombre_marca String         @unique(map: "nombre_marca_UNIQUE") @db.VarChar(100)
  estado       Boolean?       @default(true)
  created_at   DateTime?      @default(now()) @db.Timestamp(0)
  updated_at   DateTime?      @default(now()) @db.Timestamp(0)
  tb_productos tb_productos[]
}

model tb_metodo_pago {
  id_metodo_pago     String      @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  nombre_metodo_pago String      @db.VarChar(100)
  descripcion        String?     @db.VarChar(255)
  estado             Int?        @default(1) @db.TinyInt
  tb_compra          tb_compra[]
  tb_ventas          tb_ventas[]
}

model tb_metodos_envio {
  id_metodo_envio String       @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  nombre_metodo   String       @db.VarChar(100)
  descripcion     String?      @db.Text
  costo_base      Decimal?     @db.Decimal(10, 2)
  tiempo_estimado String?      @db.VarChar(50)
  tb_pedidos      tb_pedidos[]
}

model tb_pais {
  id_pais       String          @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  nombre        String          @db.VarChar(100)
  tb_personas   tb_personas[]
  tb_sucursales tb_sucursales[]
}

model tb_pedidos {
  id_pedido         String              @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  id_cliente        String?             @db.VarChar(36)
  id_metodo_envio   String?             @db.VarChar(36)
  fecha_pedido      DateTime?           @db.Date
  total_pedido      Decimal?            @db.Decimal(10, 2)
  estado            String?             @db.VarChar(50)
  metodo_pago       String?             @db.VarChar(50)
  direccion_envio   String?             @db.VarChar(200)
  tb_detalle_pedido tb_detalle_pedido[]
  tb_cliente        tb_cliente?         @relation(fields: [id_cliente], references: [id_cliente], onDelete: NoAction, onUpdate: NoAction, map: "tb_pedidos_ibfk_1")
  tb_metodos_envio  tb_metodos_envio?   @relation(fields: [id_metodo_envio], references: [id_metodo_envio], onDelete: NoAction, onUpdate: NoAction, map: "tb_pedidos_ibfk_2")

  @@index([id_cliente], map: "id_cliente")
  @@index([id_metodo_envio], map: "id_metodo_envio")
}

model tb_personal {
  id_personal  String       @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  id_persona   String?      @db.VarChar(36)
  id_rol       String?      @db.VarChar(36)
  contrasenia  String       @db.VarChar(100)
  email        String?      @db.Text
  estado       Boolean
  personal_img String?      @db.Text
  tb_personas  tb_personas? @relation(fields: [id_persona], references: [id_persona], onDelete: NoAction, onUpdate: NoAction, map: "tb_personal_ibfk_1")
  tb_rol       tb_rol?      @relation(fields: [id_rol], references: [id_rol], onDelete: NoAction, onUpdate: NoAction, map: "tb_personal_ibfk_2")
  tb_ventas    tb_ventas[]

  @@index([id_persona], map: "id_persona")
  @@index([id_rol], map: "id_rol")
}

/// This model or at least one of its fields has comments in the database, and requires an additional setup for migrations: Read more: https://pris.ly/d/database-comments
model tb_personas {
  id_persona           String                 @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  nombres              String?                @db.VarChar(50)
  correo               String?                @db.VarChar(100)
  id_tipo_persona      String?                @db.VarChar(36)
  id_tipo_documento    String?                @db.VarChar(36)
  id_sexo              String?                @db.VarChar(36)
  fecha_nacimiento     DateTime?              @db.Date
  id_direccion         String?                @db.VarChar(36)
  id_pais              String?                @db.VarChar(36)
  id_tipo_telefono     String?                @db.VarChar(36)
  apellido_paterno     String?                @db.VarChar(50)
  apellido_materno     String?                @db.VarChar(50)
  numero_documento     String                 @db.VarChar(20)
  telefono             String?                @db.VarChar(20)
  razon_social         String?                @db.VarChar(250)
  estado_documento     String?                @db.VarChar(50)
  condicion_documento  String?                @db.VarChar(50)
  distrito             String?                @db.VarChar(100)
  provincia            String?                @db.VarChar(100)
  departamento         String?                @db.VarChar(100)
  tipo_persona         String?                @db.VarChar(100)
  actividad_economica  String?                @db.Text
  tb_cliente           tb_cliente[]
  tb_personal          tb_personal[]
  tb_tipo_persona      tb_tipo_persona?       @relation(fields: [id_tipo_persona], references: [id_tipo_persona], onDelete: NoAction, onUpdate: NoAction, map: "tb_personas_ibfk_1")
  tb_tipo_documento    tb_tipo_documento?     @relation(fields: [id_tipo_documento], references: [id_tipo_documento], onDelete: NoAction, onUpdate: NoAction, map: "tb_personas_ibfk_2")
  tb_sexo              tb_sexo?               @relation(fields: [id_sexo], references: [id_sexo], onDelete: NoAction, onUpdate: NoAction, map: "tb_personas_ibfk_3")
  tb_direccion         tb_direccion?          @relation(fields: [id_direccion], references: [id_direccion], onDelete: NoAction, onUpdate: NoAction, map: "tb_personas_ibfk_4")
  tb_pais              tb_pais?               @relation(fields: [id_pais], references: [id_pais], onDelete: NoAction, onUpdate: NoAction, map: "tb_personas_ibfk_5")
  tb_tipo_telefono     tb_tipo_telefono?      @relation(fields: [id_tipo_telefono], references: [id_tipo_telefono], onDelete: NoAction, onUpdate: NoAction, map: "tb_personas_ibfk_6")
  tb_proveedores       tb_proveedores[]
  tb_telefonos_persona tb_telefonos_persona[]

  @@index([id_direccion], map: "id_direccion")
  @@index([id_pais], map: "id_pais")
  @@index([id_sexo], map: "id_sexo")
  @@index([id_tipo_documento], map: "id_tipo_documento")
  @@index([id_tipo_persona], map: "id_tipo_persona")
  @@index([id_tipo_telefono], map: "id_tipo_telefono")
}

model tb_productos {
  id_producto         String                       @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  nombre_producto     String                       @unique(map: "nombre_producto_UNIQUE") @db.VarChar(100)
  descripcion         String?                      @db.Text
  stock               Int
  id_categoria        String?                      @db.VarChar(36)
  fecha_creacion      DateTime?                    @default(now()) @db.Timestamp(0)
  id_marca            String?                      @db.VarChar(36)
  is_active           Boolean
  precio_compra       Decimal                      @db.Decimal(10, 2)
  precio_venta        Decimal                      @db.Decimal(10, 2)
  producto_img        String?                      @db.Text
  fecha_ingreso       DateTime                     @db.Date
  codigo_producto     String?                      @unique(map: "codigo_producto") @db.VarChar(255)
  updated_at          DateTime?                    @default(now()) @db.Timestamp(0)
  estado_produto      tb_productos_estado_produto? @default(Disponible)
  id_sucursal         String?                      @db.VarChar(36)
  id_tipo_propietario String                       @db.VarChar(36)
  precio_base_sin_igv Decimal?                     @db.Decimal(10, 2)
  tb_detalle_compra   tb_detalle_compra[]
  tb_detalle_pedido   tb_detalle_pedido[]
  tb_detalle_venta    tb_detalle_venta[]
  tb_inventario       tb_inventario[]
  tb_kardex           tb_kardex[]
  tb_tipo_propietario tb_tipo_propietario          @relation(fields: [id_tipo_propietario], references: [id_tipo_propietario], onDelete: NoAction, onUpdate: NoAction, map: "fk_producto_tipo_propietario")
  tb_categorias       tb_categorias?               @relation(fields: [id_categoria], references: [id_categoria], onDelete: NoAction, onUpdate: NoAction, map: "tb_productos_ibfk_1")
  tb_marcas           tb_marcas?                   @relation(fields: [id_marca], references: [id_marca], onDelete: NoAction, onUpdate: NoAction, map: "tb_productos_ibfk_2")
  tb_sucursales       tb_sucursales?               @relation(fields: [id_sucursal], references: [id_sucursal], onDelete: NoAction, onUpdate: NoAction, map: "tb_productos_ibfk_4")

  @@index([id_tipo_propietario], map: "fk_producto_tipo_propietario")
  @@index([id_categoria], map: "id_categoria")
  @@index([id_marca], map: "id_marca")
  @@index([id_sucursal], map: "id_sucursal")
}

model tb_proveedores {
  id_proveedor     String                           @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  id_persona       String?                          @db.VarChar(36)
  estado_proveedor tb_proveedores_estado_proveedor? @default(Activo)
  created_at       DateTime?                        @default(now()) @db.Timestamp(0)
  updated_at       DateTime?                        @default(now()) @db.Timestamp(0)
  nombre_comercial String?                          @db.VarChar(100)
  total_compras    Decimal?                         @default(0.00) @db.Decimal(10, 2)
  ultima_compra    DateTime?                        @db.DateTime(0)
  tb_compra        tb_compra[]
  tb_personas      tb_personas?                     @relation(fields: [id_persona], references: [id_persona], onDelete: NoAction, onUpdate: NoAction, map: "tb_proveedores_ibfk_1")

  @@index([id_persona], map: "id_persona")
}

model tb_rol {
  id_rol      String        @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  nombre_rol  String        @db.VarChar(100)
  descripcion String?       @db.VarChar(200)
  estado      Boolean
  tb_personal tb_personal[]
}

model tb_sexo {
  id_sexo     String        @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  sexo        String        @db.VarChar(20)
  tb_personas tb_personas[]
}

model tb_sucursales {
  id_sucursal      String            @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  nombre_sucursal  String            @db.VarChar(100)
  telefono         String?           @db.VarChar(20)
  email            String?           @db.VarChar(100)
  id_direccion     String            @db.VarChar(36)
  id_tipo_telefono String?           @db.VarChar(36)
  id_pais          String?           @db.VarChar(36)
  tb_inventario    tb_inventario[]
  tb_productos     tb_productos[]
  tb_direccion     tb_direccion      @relation(fields: [id_direccion], references: [id_direccion], onDelete: NoAction, onUpdate: NoAction, map: "fk_direccion")
  tb_pais          tb_pais?          @relation(fields: [id_pais], references: [id_pais], onDelete: NoAction, onUpdate: NoAction, map: "fk_pais")
  tb_tipo_telefono tb_tipo_telefono? @relation(fields: [id_tipo_telefono], references: [id_tipo_telefono], onDelete: NoAction, onUpdate: NoAction, map: "fk_tipo_telefono")
  tb_ventas        tb_ventas[]

  @@index([id_direccion], map: "fk_direccion")
  @@index([id_pais], map: "fk_pais")
  @@index([id_tipo_telefono], map: "fk_tipo_telefono")
}

model tb_telefonos_persona {
  id_telefono      String            @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  id_persona       String?           @db.VarChar(36)
  id_tipo_telefono String?           @db.VarChar(36)
  numero_telefono  String?           @db.VarChar(20)
  tb_personas      tb_personas?      @relation(fields: [id_persona], references: [id_persona], onDelete: NoAction, onUpdate: NoAction, map: "tb_telefonos_persona_ibfk_1")
  tb_tipo_telefono tb_tipo_telefono? @relation(fields: [id_tipo_telefono], references: [id_tipo_telefono], onDelete: NoAction, onUpdate: NoAction, map: "tb_telefonos_persona_ibfk_2")

  @@index([id_persona], map: "id_persona")
  @@index([id_tipo_telefono], map: "id_tipo_telefono")
}

model tb_tipo_documento {
  id_tipo_documento String        @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  documento         String        @db.VarChar(100)
  tb_personas       tb_personas[]
}

model tb_tipo_persona {
  id_tipo_persona String        @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  tipo_persona    String        @db.VarChar(100)
  descripcion     String?       @db.Text
  tb_personas     tb_personas[]
}

model tb_tipo_propietario {
  id_tipo_propietario String         @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  descripcion         String         @db.VarChar(50)
  tb_productos        tb_productos[]
}

model tb_tipo_telefono {
  id_tipo_telefono     String                 @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  tipo_telefono        String                 @db.VarChar(50)
  descripcion          String?                @db.VarChar(100)
  tb_personas          tb_personas[]
  tb_sucursales        tb_sucursales[]
  tb_telefonos_persona tb_telefonos_persona[]
}

model tb_tipo_via {
  id_tipo_via  String         @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  codigo       String?        @db.VarChar(10)
  descripcion  String         @db.VarChar(100)
  tb_direccion tb_direccion[]
}

model tb_tipo_zona {
  id_tipo_zona String         @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  codigo       String?        @db.VarChar(10)
  descripcion  String         @db.VarChar(100)
  tb_direccion tb_direccion[]
}

model tb_ventas {
  id_venta         String                   @id @default(dbgenerated("(uuid())")) @db.VarChar(36)
  fecha_venta      DateTime?                @db.Date
  numero_documento String                   @db.VarChar(20)
  tipo_documento   tb_ventas_tipo_documento @default(BOLETA)
  subtotal         Decimal                  @db.Decimal(10, 2)
  impuesto         Decimal?                 @db.Decimal(10, 2)
  precio_total     Decimal?                 @db.Decimal(10, 2)
  id_cliente       String?                  @db.VarChar(36)
  id_metodo_pago   String?                  @db.VarChar(36)
  id_sucursal      String?                  @db.VarChar(36)
  id_personal      String?                  @db.VarChar(36)
  estado_venta     tb_ventas_estado_venta   @default(COMPLETADA)
  serie_documento  String?                  @db.VarChar(25)
  observaciones    String?                  @db.Text
  created_at       DateTime?                @default(now()) @db.Timestamp(0)
  updated_at       DateTime?                @default(now()) @db.Timestamp(0)
  tb_detalle_venta tb_detalle_venta[]
  tb_devoluciones  tb_devoluciones[]
  tb_cliente       tb_cliente?              @relation(fields: [id_cliente], references: [id_cliente], onDelete: NoAction, onUpdate: NoAction, map: "tb_ventas_ibfk_2")
  tb_metodo_pago   tb_metodo_pago?          @relation(fields: [id_metodo_pago], references: [id_metodo_pago], onDelete: NoAction, onUpdate: NoAction, map: "tb_ventas_ibfk_3")
  tb_sucursales    tb_sucursales?           @relation(fields: [id_sucursal], references: [id_sucursal], onDelete: NoAction, onUpdate: NoAction, map: "tb_ventas_ibfk_4")
  tb_personal      tb_personal?             @relation(fields: [id_personal], references: [id_personal], onDelete: NoAction, onUpdate: NoAction, map: "tb_ventas_ibfk_5")

  @@index([id_cliente], map: "id_cliente")
  @@index([id_metodo_pago], map: "id_metodo_pago")
  @@index([id_personal], map: "id_personal")
  @@index([id_sucursal], map: "id_sucursal")
}

enum tb_proveedores_estado_proveedor {
  Activo
  Inactivo
  Suspendido
}

enum tb_kardex_tipo_movimiento {
  ENTRADA
  SALIDA
}

enum tb_ventas_tipo_documento {
  FACTURA
  BOLETA
  NOTA_CREDITO
  NOTA_DEBITO
}

enum tb_cliente_tipo_cliente {
  RECURRENTE
  CASUAL
  VIP
  CORPORATIVO
}

enum tb_kardex_tipo_documento {
  COMPRA
  VENTA
}

enum tb_cliente_clasificacion {
  A
  B
  C
}

enum tb_ventas_estado_venta {
  PENDIENTE
  COMPLETADA
  ANULADA
}

enum tb_productos_estado_produto {
  Disponible
  Agotado
}
