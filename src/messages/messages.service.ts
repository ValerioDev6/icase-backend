import { Injectable, OnModuleInit } from '@nestjs/common';
import * as qrcode from 'qrcode-terminal';
import { Client, LocalAuth } from 'whatsapp-web.js';

@Injectable()
export class MessagesService implements OnModuleInit {
  private client: Client;
  private isReady = false;
  constructor() {
    this.client = new Client({
      authStrategy: new LocalAuth(),
      puppeteer: {
        args: ['--no-sandbox'],
      },
    });

    this.client.on('qr', (qr) => {
      // Generamos un QR visible en la consola
      qrcode.generate(qr, { small: true });
      console.log('⬆️  Escanea el código QR de arriba con WhatsApp en tu teléfono');
    });

    this.client.on('ready', () => {
      console.log('✅ WhatsApp conectado exitosamente!');
      this.isReady = true;
    });

    this.client.on('authenticated', () => {
      console.log('🔐 Autenticación exitosa!');
    });
  }

  async onModuleInit() {
    await this.client.initialize();
  }

  async sendMessage(phoneNumber: string, message: string) {
    if (!this.isReady) {
      throw new Error('Cliente WhatsApp no está listo');
    }

    try {
      // Aseguramos que el número tenga el formato correcto
      const formattedNumber = phoneNumber.includes('@c.us') ? phoneNumber : `${phoneNumber}@c.us`;

      // Enviamos el mensaje
      const response = await this.client.sendMessage(formattedNumber, message);

      return {
        success: true,
        messageId: response.id.id,
        timestamp: response.timestamp,
      };
    } catch (error) {
      throw new Error(`Error al enviar mensaje: ${error.message}`);
    }
  }

  // Método para enviar mensajes a múltiples números
  async sendBulkMessages(numbers: string[], message: string) {
    if (!this.isReady) {
      throw new Error('Cliente WhatsApp no está listo');
    }

    const results = [];

    for (const number of numbers) {
      try {
        const result = await this.sendMessage(number, message);
        results.push({ number, ...result });
      } catch (error) {
        results.push({
          number,
          success: false,
          error: error.message,
        });
      }
    }

    return results;
  }
}
