/* eslint-disable @typescript-eslint/no-unused-vars */
import { TDocumentDefinitions } from 'pdfmake/interfaces';
import { tb_marcas as Marca } from '@prisma/client';
import { footerSection } from './sections/footer.section';
import { headerVerticalSection } from './sections/header_vertical';

interface ReportOptions {
  title?: string;
  subTitle?: string;
  marcas: Marca[];
}

export const getMarcasReport = (options: ReportOptions): TDocumentDefinitions => {
  const { title, subTitle, marcas } = options;

  const formatEstado = (estado: boolean) => ({
    text: estado ? 'Activo' : 'Inactivo',
    style: {
      color: estado ? 'green' : 'red',
      bold: true,
    },
  });

  const formatFecha = (fecha: Date) => {
    return new Date(fecha).toLocaleDateString('es-PE', {
      day: '2-digit',
      month: 'long',
      year: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    });
  };

  const rowsPerPage = 15;
  const pages = Math.ceil(marcas.length / rowsPerPage);
  const content = [];

  for (let pageIndex = 0; pageIndex < pages; pageIndex++) {
    const start = pageIndex * rowsPerPage;
    const end = start + rowsPerPage;
    const marcasPage = marcas.slice(start, end);

    content.push({
      layout: {
        hLineWidth: function (i: number, node: any) {
          if (i === node.table.body.length) return 0;
          return i === 0 ? 1.5 : 1;
        },
        vLineWidth: function (i: number, node: any) {
          return i === 0 || i === node.table.widths.length ? 1.5 : 1;
        },
        hLineColor: function (i: number, node: any) {
          return i === 0 ? '#1a237e' : '#dddddd';
        },
        vLineColor: function (i: number) {
          return '#dddddd';
        },
        paddingLeft: function (i: number) {
          return 4;
        },
        paddingRight: function (i: number) {
          return 4;
        },
        paddingTop: function (i: number) {
          return 3;
        },
        paddingBottom: function (i: number) {
          return 3;
        },
      },
      table: {
        headerRows: 1,
        widths: ['45%', '25%', '30%'],
        body: [
          [
            {
              text: 'Nombre Marca',
              fillColor: '#1a237e',
              color: 'white',
              style: { bold: true },
              margin: [2, 1],
            },
            {
              text: 'Estado Marca',
              fillColor: '#1a237e',
              color: 'white',
              style: { bold: true },
              margin: [2, 1],
            },
            {
              text: 'Fecha Creación',
              fillColor: '#1a237e',
              color: 'white',
              style: { bold: true },
              margin: [2, 1],
            },
          ],
          ...marcasPage.map((marca) => [
            {
              text: marca.nombre_marca,
              margin: [2, 1],
            },
            {
              ...formatEstado(marca.estado),
              alignment: 'left',
              margin: [2, 1],
            },
            {
              text: formatFecha(marca.created_at),
              alignment: 'center',
              margin: [2, 1],
            },
          ]),
        ],
      },
    });

    content.push({
      columns: [
        { width: '*', text: '' },
        {
          width: 'auto',
          table: {
            widths: ['auto', 'auto'],
            body: [
              [
                { text: 'Total:', alignment: 'right', bold: true, margin: [0, 5, 10, 0] },
                {
                  text: `${marcas.length} marcas`,
                  alignment: 'left',
                  bold: true,
                  margin: [0, 5, 0, 0],
                },
              ],
            ],
          },
          layout: 'noBorders',
        },
      ],
      margin: [0, 5],
    });

    if (pageIndex < pages - 1) {
      content.push({ text: '', pageBreak: 'after' });
    }
  }

  return {
    pageOrientation: 'portrait',
    header: headerVerticalSection({
      title: title ?? 'REPORTE DE MARCAS',
      subTitle: subTitle ?? 'Listado de marcas',
    }),
    footer: footerSection,
    pageMargins: [40, 100, 40, 80],
    content: content,
    defaultStyle: {
      fontSize: 9.5,
    },
  };
};
