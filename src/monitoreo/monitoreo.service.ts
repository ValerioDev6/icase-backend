import { Injectable } from '@nestjs/common';
import * as winston from 'winston';

@Injectable()
export class LogService {
  private logger: winston.Logger;

  constructor() {
    this.logger = winston.createLogger({
      level: 'warn',
      format: winston.format.combine(winston.format.timestamp(), winston.format.json()),
      transports: [new winston.transports.File({ filename: 'logs/monitorio.log' })],
    });
  }

  createErrorLog(message: string, trace: any | string) {
    this.logger.error(message, trace);
  }
}
