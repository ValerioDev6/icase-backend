import { TDocumentDefinitions } from 'pdfmake/interfaces';
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
    };
  };
  tb_personal?: {
    tb_personas: {
      nombres: string;
      apellido_paterno: string;
      apellido_materno: string;
    };
  };
  tb_metodo_pago?: {
    nombre_metodo_pago: string;
  };
}

interface TicketOptions {
  venta: VentaData;
  nombreEmpresa?: string;
  direccionEmpresa?: string;
  rucEmpresa?: string;
}

export const getVentaTicket = (options: TicketOptions): TDocumentDefinitions => {
  const {
    venta,
    nombreEmpresa = 'MI EMPRESA S.A.C',
    direccionEmpresa = 'Av. Principal 123',
    rucEmpresa = '20123456789',
  } = options;

  const formatFecha = (fecha?: Date) => {
    return fecha
      ? new Date(fecha).toLocaleDateString('es-PE', {
          day: '2-digit',
          month: '2-digit',
          year: 'numeric',
        }) +
          ' ' +
          new Date(fecha).toLocaleTimeString('es-PE', {
            hour: '2-digit',
            minute: '2-digit',
          })
      : 'Sin fecha';
  };

  const formatNombreCompleto = (persona?: {
    tb_personas: { nombres: string; apellido_paterno: string; apellido_materno: string };
  }) => {
    return persona
      ? `${persona.tb_personas.nombres} ${persona.tb_personas.apellido_paterno} ${persona.tb_personas.apellido_materno || ''}`.trim()
      : 'Sin nombre';
  };

  const formatPrecio = (precio?: Decimal) => {
    return precio ? `S/. ${precio.toFixed(2)}` : 'S/. 0.00';
  };

  return {
    pageSize: {
      width: 220,
      height: 'auto',
    },
    pageMargins: [10, 10, 10, 10],
    content: [
      // Encabezado
      {
        text: nombreEmpresa,
        alignment: 'center',
        bold: true,
        fontSize: 12,
        margin: [0, 0, 0, 5],
      },
      {
        text: direccionEmpresa,
        alignment: 'center',
        fontSize: 8,
        margin: [0, 0, 0, 2],
      },
      {
        text: `RUC: ${rucEmpresa}`,
        alignment: 'center',
        fontSize: 8,
        margin: [0, 0, 0, 5],
      },
      {
        canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1 }],
        margin: [0, 5, 0, 5],
      },
      // Datos del Comprobante
      {
        columns: [
          {
            width: '*',
            text: `${venta.tipo_documento}`,
            bold: true,
            fontSize: 10,
          },
          {
            width: 'auto',
            text: `${venta.serie_documento}-${venta.numero_documento}`,
            fontSize: 10,
          },
        ],
        margin: [0, 0, 0, 5],
      },
      {
        text: `Fecha: ${formatFecha(venta.created_at)}`,
        fontSize: 8,
        margin: [0, 0, 0, 5],
      },
      // Datos del Cliente
      {
        text: 'CLIENTE',
        bold: true,
        fontSize: 8,
        margin: [0, 0, 0, 2],
      },
      {
        text: formatNombreCompleto(venta.tb_cliente),
        fontSize: 8,
        margin: [0, 0, 0, 2],
      },
      {
        text: `DNI: ${venta.tb_cliente?.tb_personas.numero_documento || 'Sin documento'}`,
        fontSize: 8,
        margin: [0, 0, 0, 5],
      },
      {
        canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1, dash: { length: 2 } }],
        margin: [0, 5, 0, 5],
      },
      // Totales
      {
        columns: [
          { text: 'SUBTOTAL:', width: '*', fontSize: 8, alignment: 'right' },
          { text: formatPrecio(venta.subtotal), width: 'auto', fontSize: 8, alignment: 'right' },
        ],
        margin: [0, 0, 0, 2],
      },
      {
        columns: [
          { text: 'IGV:', width: '*', fontSize: 8, alignment: 'right' },
          { text: formatPrecio(venta.impuesto), width: 'auto', fontSize: 8, alignment: 'right' },
        ],
        margin: [0, 0, 0, 2],
      },
      {
        columns: [
          { text: 'TOTAL:', width: '*', fontSize: 10, bold: true, alignment: 'right' },
          {
            text: formatPrecio(venta.precio_total),
            width: 'auto',
            fontSize: 10,
            bold: true,
            alignment: 'right',
          },
        ],
        margin: [0, 0, 0, 5],
      },
      {
        canvas: [{ type: 'line', x1: 0, y1: 0, x2: 200, y2: 0, lineWidth: 1, dash: { length: 2 } }],
        margin: [0, 5, 0, 5],
      },
      // Método de Pago
      {
        columns: [
          { text: 'MÉTODO DE PAGO:', width: '*', fontSize: 8 },
          {
            text: venta.tb_metodo_pago?.nombre_metodo_pago || 'Sin método',
            width: 'auto',
            fontSize: 8,
          },
        ],
        margin: [0, 0, 0, 2],
      },
      // Vendedor
      {
        columns: [
          { text: 'ATENDIDO POR:', width: '*', fontSize: 8 },
          { text: formatNombreCompleto(venta.tb_personal), width: 'auto', fontSize: 8 },
        ],
        margin: [0, 0, 0, 5],
      },
      // Pie de página
      {
        text: '¡Gracias por su compra!',
        alignment: 'center',
        fontSize: 10,
        bold: true,
        margin: [0, 10, 0, 5],
      },
    ],
  };
};
