# 📱 API Sistema de Ventas e Inventario - iCases Store

API REST completa para la gestión integral de tiendas de retail, especializada en control de inventario, ventas, compras y administración de punto de venta (POS). Desarrollada con NestJS, Prisma y PostgreSQL.

## 📋 Descripción

Sistema backend robusto que proporciona una solución completa para la gestión de tiendas retail, incluyendo control de inventario en tiempo real, sistema de ventas POS, gestión de compras, reportes avanzados en PDF/Excel, y administración completa de productos, clientes y proveedores.

## 🚀 Tecnologías

- **NestJS** - Framework progresivo de Node.js
- **TypeScript** - Lenguaje de programación
- **Prisma ORM** - ORM de próxima generación
- **PostgreSQL** - Base de datos relacional
- **Passport JWT** - Autenticación
- **PDFMake** - Generación de PDFs
- **ExcelJS** - Generación de reportes Excel
- **Throttler** - Rate limiting
- **Google reCAPTCHA** - Seguridad anti-bot
- **Winston** - Sistema de logs

## 📁 Estructura del Proyecto

```
src/
├── main.ts                         # Punto de entrada de la aplicación
├── app.module.ts                   # Módulo principal
│
├── auth/                           # Autenticación y autorización
│   ├── decorators/                 # Decoradores personalizados
│   │   ├── auth.decorator.ts
│   │   ├── get-user.decorator.ts
│   │   └── role-protected.decorator.ts
│   ├── guards/                     # Guards de seguridad
│   │   ├── custom-throttler.guard.ts
│   │   └── use-role.guard.ts
│   ├── strategies/                 # Estrategias de autenticación
│   │   └── jwt.strategy.ts
│   ├── dto/
│   ├── filter/
│   └── interfaces/
│
├── prisma/                         # Configuración de Prisma
│   ├── prima.module.ts
│   └── prisma.service.ts
│
├── common/                         # Módulos compartidos
│   └── dtos/
│       ├── pagination.dto.ts
│       └── pagination-kardex.dto.ts
│
├── products/                       # Gestión de productos
│   ├── dto/
│   ├── entities/
│   ├── products.controller.ts
│   ├── products.service.ts
│   └── products.module.ts
│
├── categorie/                      # Categorías de productos
│   ├── dto/
│   ├── entities/
│   ├── categorie.controller.ts
│   ├── categorie.service.ts
│   └── categorie.module.ts
│
├── marcas/                         # Marcas de productos
│   ├── dto/
│   ├── entities/
│   ├── marcas.controller.ts
│   ├── marcas.service.ts
│   └── marcas.module.ts
│
├── inventario/                     # Control de inventario
│   ├── dto/
│   ├── entities/
│   ├── inventario.controller.ts
│   ├── inventario.service.ts
│   └── inventario.module.ts
│
├── kardex/                         # Kardex (movimientos de inventario)
│   ├── dto/
│   ├── entities/
│   ├── kardex.controller.ts
│   ├── kardex.service.ts
│   └── kardex.module.ts
│
├── movimientos/                    # Movimientos de stock
│   ├── dto/
│   ├── entities/
│   ├── movimientos.controller.ts
│   ├── movimientos.service.ts
│   └── movimientos.module.ts
│
├── ventas/                         # Gestión de ventas
│   ├── dto/
│   ├── entities/
│   ├── ventas.controller.ts
│   ├── ventas.service.ts
│   └── ventas.module.ts
│
├── sales/                          # Módulo auxiliar de ventas
│   ├── sales.controller.ts
│   ├── sales.service.ts
│   └── sales.module.ts
│
├── compras/                        # Gestión de compras
│   ├── dto/
│   ├── entities/
│   ├── compras.controller.ts
│   ├── compras.service.ts
│   └── compras.module.ts
│
├── cliente/                        # Gestión de clientes
│   ├── dto/
│   ├── entities/
│   ├── cliente.controller.ts
│   ├── cliente.service.ts
│   └── cliente.module.ts
│
├── proveedores/                    # Gestión de proveedores
│   ├── dto/
│   ├── entities/
│   ├── proveedores.controller.ts
│   ├── proveedores.service.ts
│   └── proveedores.module.ts
│
├── personal/                       # Gestión de empleados
│   ├── dto/
│   ├── entities/
│   ├── personal.controller.ts
│   ├── personal.service.ts
│   └── personal.module.ts
│
├── persona/                        # Información personal
│   ├── dto/
│   ├── entities/
│   ├── persona.controller.ts
│   ├── persona.service.ts
│   └── persona.module.ts
│
├── roles/                          # Sistema de roles
│   ├── dto/
│   ├── entities/
│   ├── roles.controller.ts
│   ├── roles.service.ts
│   └── roles.module.ts
│
├── metodo-pagos/                   # Métodos de pago
│   ├── dto/
│   ├── entities/
│   ├── metodo-pagos.controller.ts
│   ├── metodo-pagos.service.ts
│   └── metodo-pagos.module.ts
│
├── ajustes/                        # Ajustes de inventario
│   ├── dto/
│   ├── entities/
│   ├── ajustes.controller.ts
│   ├── ajustes.service.ts
│   └── ajustes.module.ts
│
├── direccion/                      # Direcciones
│   ├── dto/
│   ├── entities/
│   ├── direccion.controller.ts
│   ├── direccion.service.ts
│   └── direccion.module.ts
│
├── surcursal/                      # Sucursales
│   ├── dto/
│   ├── entities/
│   ├── surcursal.controller.ts
│   ├── surcursal.service.ts
│   └── surcursal.module.ts
│
├── informes/                       # Generación de informes
│   ├── dtos/
│   │   ├── filter-compras.dto.ts
│   │   ├── filter-proveedores.dto.ts
│   │   └── filter-ventas.dto.ts
│   ├── informes.controller.ts
│   ├── informes.service.ts
│   └── informes.module.ts
│
├── reports/                        # Generación de reportes
│   ├── pdf/                        # Reportes en PDF
│   │   ├── categorias.report.ts
│   │   ├── clientes.report.ts
│   │   ├── compras_pdf.report.ts
│   │   ├── kardex-report-pdf.ts
│   │   ├── marcas.report.ts
│   │   ├── personal.report.ts
│   │   ├── productos.report.ts
│   │   ├── proveedor.report.ts
│   │   ├── ventas.report.ts
│   │   ├── ventas_ticket.report.ts
│   │   └── sections/
│   │       ├── footer.section.ts
│   │       ├── header.section.ts
│   │       └── header_vertical.ts
│   ├── excel/                      # Reportes en Excel
│   │   ├── categorias.report.ts
│   │   ├── compras_excel.report.ts
│   │   ├── kardex_report_excel.ts
│   │   ├── marcas.report.ts
│   │   ├── producto.report.ts
│   │   └── ventas_excel_report.ts
│   └── html/                       # Reportes en HTML
│       ├── compras_by_id_report.ts
│       ├── producto_detalles_report.ts
│       └── ventas_by_id_report.ts
│
├── reports-pdf/                    # Controlador de reportes PDF
│   ├── basic-reports.controller.ts
│   ├── basic-reports.service.ts
│   └── basic-reports.module.ts
│
├── report-excel/                   # Controlador de reportes Excel
│   ├── basic-reports-excel.controller.ts
│   ├── basic-reports-excel.service.ts
│   └── basic-reports-excel.module.ts
│
├── report-html/                    # Controlador de reportes HTML
│   ├── report-html.controller.ts
│   ├── report-html.service.ts
│   └── report-html.module.ts
│
├── uploads-excel/                  # Carga masiva desde Excel
│   ├── uploads-excel.controller.ts
│   ├── uploads-excel.service.ts
│   └── uploads-excel.module.ts
│
├── printer/                        # Servicio de impresión
│   ├── printer.service.ts
│   └── printer.module.ts
│
├── chats/                          # Integración con IA/Chatbot
│   ├── dtos/
│   ├── use-cases/
│   ├── chats.controller.ts
│   ├── chats.service.ts
│   └── chats.module.ts
│
├── messages/                       # Sistema de mensajería
│   ├── messages.controller.ts
│   ├── messages.service.ts
│   └── messages.module.ts
│
├── monitoreo/                      # Monitoreo del sistema
│   ├── monitoreo.service.ts
│   └── monitoreo.module.ts
│
├── helpers/                        # Funciones auxiliares
│   ├── currency-formatter.ts
│   ├── date-formatter.ts
│   ├── html-to-pdfmake.ts
│   └── index.ts
│
└── Módulos de datos maestros/
    ├── pais/                       # Países
    ├── sexo/                       # Género
    ├── tipo-documento/             # Tipos de documento
    ├── tipo-persona/               # Tipos de persona
    ├── tipo-propietario/           # Tipos de propietario
    ├── tipo-telefono/              # Tipos de teléfono
    ├── tipo-via/                   # Tipos de vía
    ├── tipo-zona/                  # Tipos de zona
    └── telefono-personal/          # Teléfonos personales
```

## 🔑 Características Principales

### 💼 Gestión Comercial
- ✅ Sistema de ventas POS completo
- ✅ Gestión de compras a proveedores
- ✅ Control de múltiples métodos de pago
- ✅ Gestión de clientes y proveedores
- ✅ Sistema de sucursales
- ✅ Tickets de venta imprimibles

### 📦 Control de Inventario
- ✅ Inventario en tiempo real
- ✅ Sistema Kardex (PEPS/UEPS)
- ✅ Movimientos de stock detallados
- ✅ Ajustes de inventario
- ✅ Alertas de stock mínimo
- ✅ Control por categorías y marcas

### 📊 Reportes y Analytics
- ✅ Reportes PDF personalizados
- ✅ Exportación a Excel
- ✅ Reportes HTML interactivos
- ✅ Informes de ventas por período
- ✅ Informes de compras
- ✅ Reportes de Kardex
- ✅ Análisis de proveedores
- ✅ Estadísticas de productos

### 🔐 Seguridad y Control
- ✅ Autenticación JWT
- ✅ Sistema de roles y permisos
- ✅ Rate limiting (Throttler)
- ✅ Protección con reCAPTCHA
- ✅ Guards personalizados
- ✅ Decoradores de autorización

### 🛠️ Funcionalidades Avanzadas
- ✅ Carga masiva desde Excel
- ✅ Chat/Asistente IA
- ✅ Sistema de mensajería
- ✅ Monitoreo de sistema
- ✅ Logging avanzado
- ✅ Formateo de monedas y fechas

## 🛠️ Instalación

### Prerrequisitos
- Node.js (v18 o superior)
- PostgreSQL
- npm o pnpm

### Pasos de instalación

```bash
# Clonar el repositorio
git clone [url-del-repositorio]

# Instalar dependencias
npm install
# o
pnpm install

# Configurar variables de entorno
cp .env.example .env
# Editar .env con tus configuraciones

# Generar cliente de Prisma
npx prisma generate

# Ejecutar migraciones
npx prisma migrate dev

# Ejecutar seeders (opcional)
npm run seed

# Iniciar en desarrollo
npm run start:dev
```

## 🗄️ Base de Datos

```bash
# Crear una migración
npx prisma migrate dev --name nombre_migracion

# Aplicar migraciones
npx prisma migrate deploy

# Abrir Prisma Studio (GUI)
npx prisma studio

# Resetear base de datos
npx prisma migrate reset
```

## 📝 Variables de Entorno

```env
# Server
PORT=3000
NODE_ENV=development

# Database
DATABASE_URL="postgresql://user:password@localhost:5432/icases_store?schema=public"

# JWT
JWT_SECRET=your_jwt_secret_key_here
JWT_EXPIRES_IN=24h

# Google reCAPTCHA
RECAPTCHA_SECRET_KEY=your_recaptcha_secret

# Rate Limiting
THROTTLE_TTL=60
THROTTLE_LIMIT=10

# Cors
FRONTEND_URL=http://localhost:4200
```

## 💻 Scripts Disponibles

```bash
# Desarrollo
npm run start          # Inicia servidor
npm run start:dev      # Inicia en modo watch
npm run start:debug    # Inicia con debug

# Producción
npm run build         # Compila TypeScript
npm run start:prod    # Inicia en producción

# Testing
npm run test          # Ejecuta tests
npm run test:watch    # Tests en modo watch
npm run test:cov      # Tests con cobertura
npm run test:e2e      # Tests end-to-end

# Linting y formato
npm run lint          # Ejecuta ESLint
npm run format        # Formatea código

# Prisma
npm run prisma:generate   # Genera cliente Prisma
npm run prisma:migrate    # Ejecuta migraciones
npm run prisma:studio     # Abre Prisma Studio
```

## 📚 Documentación API

### Autenticación
- `POST /api/auth/login` - Iniciar sesión
- `POST /api/auth/register` - Registrar usuario
- `POST /api/auth/change-password` - Cambiar contraseña
- `GET /api/auth/validate` - Validar token

### Productos
- `GET /api/products` - Listar productos
- `GET /api/products/:id` - Obtener producto
- `POST /api/products` - Crear producto
- `PUT /api/products/:id` - Actualizar producto
- `DELETE /api/products/:id` - Eliminar producto

### Ventas
- `GET /api/ventas` - Listar ventas
- `GET /api/ventas/:id` - Obtener venta
- `POST /api/ventas` - Registrar venta
- `PUT /api/ventas/:id` - Actualizar venta
- `DELETE /api/ventas/:id` - Anular venta

### Compras
- `GET /api/compras` - Listar compras
- `GET /api/compras/:id` - Obtener compra
- `POST /api/compras` - Registrar compra
- `PUT /api/compras/:id` - Actualizar compra
- `DELETE /api/compras/:id` - Anular compra

### Inventario
- `GET /api/inventario` - Consultar inventario
- `GET /api/inventario/:id` - Stock de producto
- `POST /api/inventario/ajuste` - Ajustar inventario
- `GET /api/kardex` - Consultar kardex
- `GET /api/kardex/:producto` - Kardex de producto

### Clientes
- `GET /api/cliente` - Listar clientes
- `GET /api/cliente/:id` - Obtener cliente
- `POST /api/cliente` - Crear cliente
- `PUT /api/cliente/:id` - Actualizar cliente
- `DELETE /api/cliente/:id` - Eliminar cliente

### Proveedores
- `GET /api/proveedores` - Listar proveedores
- `GET /api/proveedores/:id` - Obtener proveedor
- `POST /api/proveedores` - Crear proveedor
- `PUT /api/proveedores/:id` - Actualizar proveedor
- `DELETE /api/proveedores/:id` - Eliminar proveedor

### Reportes
- `GET /api/reports-pdf/productos` - PDF de productos
- `GET /api/reports-pdf/ventas` - PDF de ventas
- `GET /api/reports-pdf/compras` - PDF de compras
- `GET /api/reports-pdf/kardex` - PDF de kardex
- `GET /api/reports-pdf/ticket/:id` - Ticket de venta
- `GET /api/report-excel/productos` - Excel de productos
- `GET /api/report-excel/ventas` - Excel de ventas
- `GET /api/report-excel/compras` - Excel de compras

### Informes
- `POST /api/informes/ventas` - Informe de ventas por período
- `POST /api/informes/compras` - Informe de compras por período
- `POST /api/informes/proveedores` - Informe de proveedores

## 📊 Características del Sistema de Reportes

### Reportes PDF
- Tickets de venta personalizados
- Reportes de inventario
- Kardex detallado
- Listados de productos, clientes, proveedores
- Headers y footers personalizables
- Formato vertical y horizontal

### Reportes Excel
- Exportación completa de datos
- Filtros avanzados
- Formato profesional
- Datos para análisis

### Reportes HTML
- Vista detallada de transacciones
- Diseño responsive
- Impresión optimizada

## 🔐 Sistema de Roles y Permisos

El sistema incluye roles predefinidos:
- **Administrador**: Acceso completo
- **Gerente**: Gestión de ventas, compras e inventario
- **Vendedor**: Registro de ventas
- **Almacenero**: Gestión de inventario

## 🚨 Sistema de Monitoreo

- Logging de errores y eventos
- Monitoreo de rendimiento
- Alertas de stock bajo
- Registro de actividades de usuarios

## 🤝 Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request



## 👨‍💻 Desarrollado para

**iCases Store** - Sistema integral de gestión retail

---

Desarrollado con ❤️ usando NestJS, Prisma y PostgreSQL