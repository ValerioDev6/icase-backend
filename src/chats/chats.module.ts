import { Module } from '@nestjs/common';
import { ChatsService } from './chats.service';
import { ChatsController } from './chats.controller';
import { PrinterModule } from 'src/printer/printer.module';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  controllers: [ChatsController],
  imports: [PrinterModule, AuthModule],
  providers: [ChatsService],
})
export class ChatsModule {}
