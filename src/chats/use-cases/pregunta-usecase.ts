import OpenAI from 'openai';
interface Options {
  prompt: string;
}

export const preguntaCheckUseCase = async (openai: OpenAI, options: Options) => {
  const { prompt } = options;

  const completion = await openai.chat.completions.create({
    messages: [
      { role: 'system', content: 'Soy Icase Store Bot En que puedo ayudarte?' },
      {
        role: 'user',
        content: prompt,
      },
    ],
    model: 'gpt-3.5-turbo',
    max_tokens: 100, // Asignar un valor por defecto
  });

  return completion.choices[0];
};
