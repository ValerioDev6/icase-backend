import { BadRequestException, Injectable, Logger } from '@nestjs/common';
import * as csvParse from 'csv-parse/sync';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UploadsExcelService {
  private readonly logger = new Logger('UploadsExcelService');

  constructor(private readonly prisma: PrismaService) {}

  async uploadExcelProducto(file: Express.Multer.File) {
    // Validar extensión de archivo
    if (!['text/csv', 'application/vnd.ms-excel'].includes(file.mimetype)) {
      throw new BadRequestException('Solo se permiten archivos CSV');
    }

    try {
      // Parsear el CSV a JSON
      const records = csvParse.parse(file.buffer.toString('utf-8'), {
        columns: true,
        skip_empty_lines: true,
      });

      this.logger.log(`Registros parseados: ${records.length}`);

      // Preparar datos para inserción masiva
      const productosParaInsertar = records.map((record) => ({
        nombre_producto: record.nombre_producto,
        descripcion: record.descripcion || null,
        stock: parseInt(record.stock, 10),
        id_categoria: record.id_categoria,
        id_marca: record.id_marca,
        is_active: true,
        precio_compra: parseFloat(record.precio_compra),
        precio_venta: parseFloat(record.precio_venta),
        fecha_ingreso: new Date(),
        id_sucursal: record.id_sucursal,
        id_tipo_propietario: record.id_tipo_propietario,
      }));

      // Inserción masiva
      const result = await this.prisma.tb_productos.createMany({
        data: productosParaInsertar,
        skipDuplicates: true,
      });

      this.logger.log(`Productos insertados: ${result.count}`);

      return result;
    } catch (error) {
      this.logger.error('Error al procesar archivo', error.stack);
      throw new BadRequestException('Error al procesar el archivo');
    }
  }
}
