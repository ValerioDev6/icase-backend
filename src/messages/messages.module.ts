import { Module } from '@nestjs/common';
import { MessagesService } from './messages.service';
import { MessagesController } from './messages.controller';
import { PrismaModule } from 'src/prisma/prima.module';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  controllers: [MessagesController],
  imports: [PrismaModule, AuthModule],
  providers: [MessagesService],
})
export class MessagesModule {}
