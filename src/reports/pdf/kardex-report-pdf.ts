import { TDocumentDefinitions } from 'pdfmake/interfaces';
import { headerSection } from './sections/header.section';
import { footerSection } from './sections/footer.section';
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
  subTitle?: string;
  kardex: KardexData[];
}

export const getKardexReport = (options: ReportOptions): TDocumentDefinitions => {
  const { title, subTitle, kardex } = options;

  // Formatear fecha
  const formatFecha = (fecha?: Date) => {
    return fecha
      ? new Date(fecha).toLocaleDateString('es-PE', {
          day: '2-digit',
          month: 'long',
          year: 'numeric',
        })
      : 'Sin fecha';
  };

  // Formatear precio
  const formatPrecio = (precio?: Decimal) => {
    return precio ? `S/. ${precio.toFixed(2)}` : 'S/. 0.00';
  };

  // Calcular totales
  const totalMovimientos = kardex.length;
  const totalCantidad = kardex.reduce((sum, item) => sum + (item.cantidad || 0), 0);
  const totalValor = kardex.reduce((sum, item) => sum + (item.total?.toNumber() || 0), 0);

  // Agrupar por tipo de movimiento
  const tiposMovimiento = kardex.reduce(
    (acc, item) => {
      const tipo = item.tipo_movimiento || 'Sin tipo';
      if (!acc[tipo]) {
        acc[tipo] = {
          cantidad: 0,
          total: 0,
        };
      }
      acc[tipo].cantidad += item.cantidad || 0;
      acc[tipo].total += item.total?.toNumber() || 0;
      return acc;
    },
    {} as Record<string, { cantidad: number; total: number }>,
  );

  return {
    pageOrientation: 'landscape',
    header: headerSection({
      title: title ?? 'REPORTE DE KARDEX',
      subtitle: subTitle ?? 'Movimientos de Inventario',
    }),
    footer: footerSection,
    pageMargins: [40, 100, 40, 50],
    content: [
      {
        text: 'Detalle de Movimientos de Kardex',
        style: {
          fontSize: 16,
          bold: true,
          margin: [0, 0, 0, 20],
        },
      },
      {
        layout: 'customLayout01',
        table: {
          headerRows: 1,
          widths: ['*', '15%', '10%', '10%', '10%', '10%', '10%', '10%'],
          body: [
            [
              { text: 'Producto', style: 'tableHeader' },
              { text: 'Fecha', style: 'tableHeader' },
              { text: 'Tipo Mov.', style: 'tableHeader' },
              { text: 'Tipo Doc.', style: 'tableHeader' },
              { text: 'Cantidad', style: 'tableHeader' },
              { text: 'P. Unitario', style: 'tableHeader' },
              { text: 'Total', style: 'tableHeader' },
              { text: 'Stock', style: 'tableHeader' },
            ],
            ...kardex.map((item) => [
              { text: item.tb_productos?.nombre_producto || 'Sin producto' },
              { text: formatFecha(item.fecha_movimiento) },
              { text: item.tipo_movimiento || 'Sin tipo' },
              { text: item.tipo_documento || 'Sin documento' },
              { text: item.cantidad?.toString() || '0' },
              { text: formatPrecio(item.precio_unitario) },
              { text: formatPrecio(item.total) },
              {
                text: `${item.stock_anterior || 0} → ${item.stock_actual || 0}`,
                alignment: 'center',
              },
            ]),
          ],
        },
      },
      {
        text: 'Resumen de Movimientos',
        style: {
          fontSize: 16,
          bold: true,
          margin: [0, 20, 0, 10],
        },
      },
      {
        layout: 'noBorders',
        table: {
          widths: ['*', 'auto', 'auto'],
          body: [
            [
              {},
              { text: 'Total de Movimientos', bold: true, alignment: 'right' },
              { text: totalMovimientos.toString(), bold: true, alignment: 'center' },
            ],
            [
              {},
              { text: 'Cantidad Total', bold: true, alignment: 'right' },
              { text: totalCantidad.toString(), bold: true, alignment: 'center' },
            ],
            [
              {},
              { text: 'Valor Total', bold: true, alignment: 'right' },
              { text: `S/. ${totalValor.toFixed(2)}`, bold: true, alignment: 'center' },
            ],
          ],
        },
      },
      {
        text: 'Detalle por Tipo de Movimiento',
        style: {
          fontSize: 16,
          bold: true,
          margin: [0, 20, 0, 10],
        },
      },
      {
        layout: 'lightHorizontalLines',
        table: {
          widths: ['*', 'auto', 'auto'],
          body: [
            [
              { text: 'Tipo de Movimiento', bold: true },
              { text: 'Cantidad', bold: true, alignment: 'center' },
              { text: 'Valor Total', bold: true, alignment: 'right' },
            ],
            ...Object.entries(tiposMovimiento).map(([tipo, datos]) => [
              { text: tipo },
              { text: datos.cantidad.toString(), alignment: 'center' },
              { text: `S/. ${datos.total.toFixed(2)}`, alignment: 'right' },
            ]),
          ],
        },
      },
    ],
    styles: {
      tableHeader: {
        bold: true,
        color: 'white',
      },
    },
    defaultStyle: {
      fontSize: 8,
    },
  };
};
