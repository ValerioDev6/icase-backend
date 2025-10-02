import { Body, Controller, Post } from '@nestjs/common';
import { ChatsService } from './chats.service';
import { SkipThrottle } from '@nestjs/throttler';
import { PreguntaDto } from './dtos/pregunta,dto';

@SkipThrottle()
@Controller('chats')
export class ChatsController {
  constructor(private readonly chatsService: ChatsService) {}
  @Post('pregunta')
  preguntaChatGpt(@Body() preguntaDto: PreguntaDto) {
    return this.chatsService.preguntaGpt(preguntaDto);
  }
}
