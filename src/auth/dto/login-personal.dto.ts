import { IsEmail, IsString, Matches, MaxLength, MinLength } from 'class-validator';

export class LoginPersonalDto {
  @IsString()
  @IsEmail()
  email: string;

  @IsString()
  //   @MinLength(6)
  //   @MaxLength(50)
  //   @Matches(/(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$/, {
  //     message: 'La contraseña debe tener una mayúscula, una minúscula y un número',
  //   })
  password: string;
}
