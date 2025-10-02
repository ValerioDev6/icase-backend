import { TDocumentDefinitions } from 'pdfmake/interfaces';
import { headerSection } from './sections/header.section';
import { footerSection } from './sections/footer.section';

interface PersonalData {
  id_personal: string;
  estado: boolean;
  id_rol: string;
  tb_personas?: {
    nombres: string;
  } | null;
  tb_rol?: {
    nombre_rol: string;
  } | null;
}

interface ReportOptions {
  title?: string;
  subTitle?: string;
  personal: PersonalData[];
}

export const getPersonalReportPdf = (options: ReportOptions): TDocumentDefinitions => {
  const { title, subTitle, personal } = options;

  return {
    pageOrientation: 'landscape',
    header: headerSection({
      title: title ?? 'REPORTE DE PERSONAL',
      subtitle: subTitle ?? 'Listado de personal',
    }),
    footer: footerSection,
    pageMargins: [40, 100, 40, 50],
    content: [
      {
        layout: 'customLayout01',
        table: {
          headerRows: 1,
          widths: ['20%', '30%', '25%', '25%'],
          body: [
            [
              { text: 'Código', style: { bold: true }, color: 'white' },
              { text: 'Nombre', style: { bold: true }, color: 'white' },
              { text: 'Rol', style: { bold: true }, color: 'white' },
              { text: 'Estado', style: { bold: true }, color: 'white' },
            ],
            ...personal.map((empleado) => [
              { text: empleado.id_personal.substring(0, 8) },
              { text: empleado.tb_personas?.nombres || 'Sin nombre' },
              { text: empleado.tb_rol?.nombre_rol || 'Sin rol' },
              { text: empleado.estado ? 'Activo' : 'Inactivo' },
            ]),
            [{ text: '', colSpan: 4, border: [false, false, false, false] }, {}, {}, {}],
            [
              { text: '', colSpan: 2, border: [false, false, false, false] },
              {},
              { text: 'Total Personal', alignment: 'right', bold: true },
              { text: `${personal.length}`, alignment: 'center', bold: true },
            ],
          ],
        },
      },
      {
        text: 'Resumen',
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
              { text: 'Personal Activo:', bold: true },
              {
                text: personal.filter((p) => p.estado).length.toString(),
                alignment: 'center',
              },
            ],
            [
              { text: 'Personal Inactivo:', bold: true },
              {
                text: personal.filter((p) => !p.estado).length.toString(),
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
