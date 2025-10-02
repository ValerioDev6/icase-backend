import { Injectable, OnModuleInit, Scope } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {
  async onModuleInit() {
    await this.$connect();
  }
}

// @Injectable({ scope: Scope.REQUEST })
// export class PrismaService extends PrismaClient {
//   constructor() {
//     super();
//   }

//   setTenantId(tenantId: number) {
//     this.tenantId = tenantId;
//   }
// }
