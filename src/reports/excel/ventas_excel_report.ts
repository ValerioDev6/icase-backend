import { Workbook } from 'exceljs';
import { Decimal } from '@prisma/client/runtime/library';

interface VentaData {
  fecha_venta?: Date;
  numero_documento: string;
  tipo_documento: string;
  subtotal: Decimal;
  impuesto?: Decimal;
  precio_total?: Decimal;
  estado_venta: string;
  serie_documento?: string;
  created_at: Date;
  tb_cliente?: {
    id_persona: string;
    tb_personas: {
      nombres: string;
      apellido_paterno: string;
      apellido_materno: string;
      numero_documento: string;
      correo?: string;
      telefono?: string;
    };
  };
  tb_personal?: {
    id_persona: string;
    tb_personas: {
      nombres: string;
      apellido_paterno: string;
      apellido_materno: string;
      numero_documento: string;
      correo?: string;
      telefono?: string;
    };
  };
  tb_metodo_pago?: {
    nombre_metodo_pago: string;
  };
}

interface ReportOptions {
  title?: string;
  subTitle?: string;
  ventas: VentaData[];
}

export const getVentasExcelReport = async (options: ReportOptions): Promise<Workbook> => {
  const { title = 'Reporte de Ventas', subTitle = '', ventas } = options;

  const workbook = new Workbook();
  const worksheet = workbook.addWorksheet('Ventas');

  // Configure columns
  worksheet.columns = [
    { header: 'Fecha Venta', key: 'fecha_venta', width: 20 },
    { header: 'Tipo Documento', key: 'tipo_documento', width: 20 },
    { header: 'Serie-Número', key: 'numero_documento', width: 20 },
    { header: 'Cliente', key: 'cliente', width: 30 },
    { header: 'Documento Cliente', key: 'documento_cliente', width: 20 },
    { header: 'Vendedor', key: 'vendedor', width: 30 },
    { header: 'Método Pago', key: 'metodo_pago', width: 20 },
    { header: 'Subtotal', key: 'subtotal', width: 15 },
    { header: 'Impuesto', key: 'impuesto', width: 15 },
    { header: 'Total Venta', key: 'precio_total', width: 15 },
    { header: 'Estado', key: 'estado_venta', width: 15 },
  ];

  // Add data rows
  ventas.forEach((venta) => {
    worksheet.addRow({
      fecha_venta: venta.created_at
        ? new Date(venta.created_at).toLocaleDateString('es-PE', {
            day: '2-digit',
            month: 'long',
            year: 'numeric',
          })
        : 'Sin fecha',
      tipo_documento: venta.tipo_documento || 'Sin tipo',
      numero_documento: `${venta.serie_documento || ''}-${venta.numero_documento}`.trim(),
      cliente: venta.tb_cliente
        ? `${venta.tb_cliente.tb_personas.nombres} ${venta.tb_cliente.tb_personas.apellido_paterno} ${venta.tb_cliente.tb_personas.apellido_materno}`.trim()
        : 'Sin cliente',
      documento_cliente: venta.tb_cliente?.tb_personas.numero_documento || 'Sin documento',
      vendedor: venta.tb_personal
        ? `${venta.tb_personal.tb_personas.nombres} ${venta.tb_personal.tb_personas.apellido_paterno} ${venta.tb_personal.tb_personas.apellido_materno}`.trim()
        : 'Sin vendedor',
      metodo_pago: venta.tb_metodo_pago?.nombre_metodo_pago || 'Sin método',
      subtotal: Number(venta.subtotal),
      impuesto: Number(venta.impuesto || 0),
      precio_total: Number(venta.precio_total),
      estado_venta: venta.estado_venta,
    });
  });

  // Format header row
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
      const subtotalCell = row.getCell('subtotal');
      const igvCell = row.getCell('impuesto');
      const totalCell = row.getCell('precio_total');

      subtotalCell.numFmt = '"S/. "#,##0.00';
      igvCell.numFmt = '"S/. "#,##0.00';
      totalCell.numFmt = '"S/. "#,##0.00';
    }
  });

  // Adjust column widths
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
