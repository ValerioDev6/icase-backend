import { BadRequestException, Body, Controller, Get, Post, UseGuards } from '@nestjs/common';
import { Recaptcha } from '@nestlab/google-recaptcha';
import { tb_personal } from '@prisma/client';
import { AuthService } from './auth.service';
import { Auth } from './decorators/auth.decorator';
import { GetUser } from './decorators/get-user.decorator';
import { ChangePasswordDtoIndividual } from './dto/cambiar-passowrd-individual.dto';
import { ChangePasswordDto } from './dto/change-password.dto';
import { CreatePersonalDto } from './dto/create-personal.dto';
import { LoginPersonalDto } from './dto/login-personal.dto';
import { CustomThrottlerGuard } from './guards/custom-throttler.guard';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('register')
  register(@Body() createPersonalDto: CreatePersonalDto) {
    return this.authService.register(createPersonalDto);
  }
  @UseGuards(CustomThrottlerGuard)
  @Recaptcha()
  @Post('login')
  async login(@Body() loginPersonalDto: LoginPersonalDto) {
    try {
      return await this.authService.login(loginPersonalDto);
    } catch (error) {
      if (error.response?.error === 'invalid-recaptcha') {
        throw new BadRequestException('El token de reCAPTCHA no es válido.');
      }
      throw error;
    }
  }

  @Get('check-auth-status')
  @Auth()
  checkAuthStatus(@GetUser() user: tb_personal) {
    return this.authService.checkAuthStatus(user);
  }

  @Post('change-password')
  @Auth()
  changePassword(@GetUser() user: tb_personal, @Body() changePasswordDto: ChangePasswordDto) {
    return this.authService.changePassword(user.id_personal, changePasswordDto);
  }
  // Controlador
  @Post('change-password-personal')
  changePasswordByAdmin(@Body() changePasswordDto: ChangePasswordDtoIndividual) {
    return this.authService.changePassword(changePasswordDto.idPersonal, changePasswordDto);
  }
}
