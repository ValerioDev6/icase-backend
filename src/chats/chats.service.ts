import { Injectable } from '@nestjs/common';
import OpenAI from 'openai';
import { PreguntaDto } from './dtos/pregunta,dto';
import { preguntaCheckUseCase } from './use-cases/pregunta-usecase';

@Injectable()
export class ChatsService {
  private openai = new OpenAI({
    apiKey: process.env.OPEN_API_KEY,
  });

  async preguntaGpt(preguntaDto: PreguntaDto) {
    return await preguntaCheckUseCase(this.openai, {
      prompt: preguntaDto.prompt,
    });
  }
}
