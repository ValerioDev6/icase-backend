import { Workbook } from 'exceljs';
import { Decimal } from '@prisma/client/runtime/library';

interface KardexData {
  fecha_movimiento?: Date;
  tipo_movimiento?: string;
  tipo_documento?: string;
  cantidad?: number;
  precio_unitario?: Decimal;
  total?: Decimal;
  stock_anterior?: number;
  stock_actual?: number;
  tb_productos?: {
    nombre_producto: string;
  };
}

interface ReportOptions {
  title?: string;
  kardex: KardexData[];
}

export const getKardexExcelReport = async (options: ReportOptions): Promise<Workbook> => {
  const { title = 'Reporte de Kardex', kardex } = options;
  const workbook = new Workbook();
  const worksheet = workbook.addWorksheet('Kardex');

  // Configurar columnas
  worksheet.columns = [
    { header: 'Producto', key: 'producto', width: 30 },
    { header: 'Fecha Movimiento', key: 'fecha_movimiento', width: 20 },
    { header: 'Tipo Movimiento', key: 'tipo_movimiento', width: 20 },
    { header: 'Tipo Documento', key: 'tipo_documento', width: 20 },
    { header: 'Cantidad', key: 'cantidad', width: 15 },
    { header: 'Precio Unitario', key: 'precio_unitario', width: 15 },
    { header: 'Total', key: 'total', width: 15 },
    { header: 'Stock Anterior', key: 'stock_anterior', width: 15 },
    { header: 'Stock Actual', key: 'stock_actual', width: 15 },
  ];

  // Agregar filas de datos
  kardex.forEach((item) => {
    worksheet.addRow({
      producto: item.tb_productos?.nombre_producto || 'Sin producto',
      fecha_movimiento: item.fecha_movimiento
        ? new Date(item.fecha_movimiento).toLocaleDateString('es-PE', {
            day: '2-digit',
            month: 'long',
            year: 'numeric',
          })
        : 'Sin fecha',
      tipo_movimiento: item.tipo_movimiento || 'Sin tipo',
      tipo_documento: item.tipo_documento || 'Sin documento',
      cantidad: item.cantidad || 0,
      precio_unitario: Number(item.precio_unitario),
      total: Number(item.total),
      stock_anterior: item.stock_anterior || 0,
      stock_actual: item.stock_actual || 0,
    });
  });

  // Formatear encabezado
  const headerRow = worksheet.getRow(1);
  headerRow.eachCell((cell) => {
    cell.fill = {
      type: 'pattern',
      pattern: 'solid',
      fgColor: { argb: '0160BC' },
    };
    cell.font = { bold: true, color: { argb: 'FFFFFFFF' } };
    cell.alignment = { horizontal: 'center', vertical: 'middle' };
  });

  // Formatear columnas numéricas
  worksheet.eachRow((row, rowNumber) => {
    if (rowNumber > 1) {
      const numericalColumns = [
        'cantidad',
        'precio_unitario',
        'total',
        'stock_anterior',
        'stock_actual',
      ];
      numericalColumns.forEach((colKey) => {
        const cell = row.getCell(colKey);
        cell.numFmt = '#,##0.00';
      });
    }
  });

  // Ajustar ancho de columnas
  worksheet.columns.forEach((column) => {
    let maxLength = 0;
    column.eachCell({ includeEmpty: true }, (cell) => {
      const cellValue = cell.value ? cell.value.toString() : '';
      maxLength = Math.max(maxLength, cellValue.length);
    });
    column.width = Math.min(Math.max(maxLength + 2, 15), 30);
  });

  return workbook;
};
