import { Body, Controller, Post } from '@nestjs/common';
import { SkipThrottle } from '@nestjs/throttler';
import { MessagesService } from './messages.service';
@SkipThrottle()
@Controller('messages')
export class MessagesController {
  constructor(private readonly messagesService: MessagesService) {}

  @Post('send')
  async sendMessage(@Body() body: { phoneNumber: string; message: string }) {
    return await this.messagesService.sendMessage(body.phoneNumber, body.message);
  }

  @Post('send-bulk')
  async sendBulkMessages(@Body() body: { numbers: string[]; message: string }) {
    return await this.messagesService.sendBulkMessages(body.numbers, body.message);
  }
}
