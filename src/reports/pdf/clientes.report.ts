import { TDocumentDefinitions } from 'pdfmake/interfaces';
import { headerSection } from './sections/header.section';
import { footerSection } from './sections/footer.section';
import { Decimal } from '@prisma/client/runtime/library';

interface ClienteData {
  id_cliente: string;
  estado: boolean;
  tipo_cliente: string;
  clasificacion: string;
  total_compras: Decimal;
  ultima_compra: Date | null;
  codigo_cliente: string;

  tb_personas: {
    nombres: string;
  } | null;
}

interface ReportOptions {
  title?: string;
  subTitle?: string;
  clientes: ClienteData[];
}

export const getClienteReport = (options: ReportOptions): TDocumentDefinitions => {
  const { title, subTitle, clientes } = options;

  const formatFecha = (fecha: Date | null) => {
    if (!fecha) return 'No registrada';
    return new Date(fecha).toLocaleDateString('es-PE', {
      day: '2-digit',
      month: 'long',
      year: 'numeric',
    });
  };

  const formatMonto = (monto: Decimal) => {
    return `S/. ${monto.toFixed(2)}`;
  };

  return {
    pageOrientation: 'landscape',
    header: headerSection({
      title: title ?? 'REPORTE DE CLIENTES',
      subtitle: subTitle ?? 'Listado de clientes',
    }),
    footer: footerSection,
    pageMargins: [40, 100, 40, 50],
    content: [
      {
        layout: 'customLayout01',
        table: {
          headerRows: 1,
          widths: ['15%', '10%', '10%', '10%', '15%', '15%', '15%'],
          body: [
            [
              { text: 'Código', style: { bold: true }, color: 'white' },
              { text: 'Nombre', style: { bold: true }, color: 'white' },
              { text: 'Estado', style: { bold: true }, color: 'white' },
              { text: 'Tipo', style: { bold: true }, color: 'white' },
              { text: 'Clasificación', style: { bold: true }, color: 'white' },
              { text: 'Total Compras', style: { bold: true }, color: 'white' },
              { text: 'Última Compra', style: { bold: true }, color: 'white' },
            ],
            ...clientes.map((cliente) => [
              { text: cliente.codigo_cliente || 'Sin código' },
              {
                text: cliente.tb_personas ? cliente.tb_personas.nombres : 'Sin nombre',
              },
              { text: cliente.estado ? 'Activo' : 'Inactivo' },
              { text: cliente.tipo_cliente },
              { text: cliente.clasificacion },
              {
                text: formatMonto(cliente.total_compras || new Decimal(0)),
                alignment: 'right',
              },
              {
                text: formatFecha(cliente.ultima_compra),
              },
            ]),
            [
              { text: '', colSpan: 7, border: [false, false, false, false] },
              {},
              {},
              {},
              {},
              {},
              {},
            ],
            [
              { text: '', colSpan: 5, border: [false, false, false, false] },
              {},
              {},
              {},
              {},
              { text: 'Total', alignment: 'right', bold: true },
              { text: `${clientes.length} clientes`, alignment: 'center', bold: true },
            ],
          ],
        },
      },
      {
        text: 'Totales',
        style: {
          fontSize: 18,
          bold: true,
          margin: [0, 20, 0, 10],
        },
      },
      {
        layout: 'noBorders',
        table: {
          widths: ['auto', 'auto'],
          body: [
            [
              { text: 'Total de Compras:', bold: true, alignment: 'right' },
              {
                text: formatMonto(
                  clientes.reduce((total, c) => total.plus(c.total_compras || 0), new Decimal(0)),
                ),
                bold: true,
                alignment: 'center',
              },
            ],
          ],
        },
      },
    ],
    defaultStyle: {
      fontSize: 8,
    },
  };
};
