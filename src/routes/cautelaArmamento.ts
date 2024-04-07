import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { validatePassword } from "../plugins/validatePassword";

export interface CautelaArmamento {
  id: string;
  militarNome: string;
  armamentoId: string;
  data_cautela: string;
  observacao?: string;
  companhia: string;
  validado?: string;
  resp_cautela?: string;
  status: string;
  data_fechamento_cautela: string;
  cautelouId: string;
  senha: string;
}

export async function cautelaArmamentoRoutes(fastify: FastifyInstance) {
  fastify.get("/armamento/cautela", async (request, reply) => {
    const result = await prisma.cautelaArmamento.findMany({
      include: {
        cautelou: true,
        armamento: true,
      },
    });

    return reply.status(200).send(result);
  });

  fastify.get("/armamento/cautela/:id", async (request, reply) => {
    const { id } = request.params as CautelaArmamento
    const result = await prisma.cautelaArmamento.findMany({
      where: {
        cautelouId: id
      },
      include: {
        cautelou: true,
        armamento: true,
      },
    });

    return reply.status(200).send(result);
  });

  fastify.post("/armamento/cautela/create", async (request, reply) => {
    const { observacao, cautelouId, militarNome, armamentoId, companhia, senha } =
      request.body as CautelaArmamento;
    if (senha) {
      if (await validatePassword(cautelouId, senha)) {
        const result = await prisma.cautelaArmamento.create({
          data: {
            armamentoId,
            cautelouId,
            observacao,
            companhia,
            resp_cautela: militarNome,
            validado: (await validatePassword(cautelouId, senha))
              ? true
              : false,
          },
        });
        return reply.status(201).send(result);
      }
      return reply.status(205).send({
        message: "Senha incorreta",
      });
    }else {
        const result = await prisma.cautelaArmamento.create({
            data: {
              armamentoId,
              cautelouId,
              observacao,
              companhia,
              resp_cautela: militarNome,
              validado: false,
            },
          });
          return reply.status(201).send(result);
    }
  });

  fastify.post("/armamento/cautela/validate", async (request, reply) => {
    const { militarId, senha, cautelaId } = request.body as any;
    console.log(request.body)
    const verifyStatus = await validatePassword(militarId, senha);

    if (verifyStatus === true) {
      await prisma.cautelaArmamento.update({
        where: {
          id: cautelaId,
        },
        data: {
          validado: true,
        },
      });
      return reply
        .status(202)
        .send({ message: "Senha correta, cautela validada!" });
    } else {
      return reply.send({ message: "Senha incorreta." });
    }
  });

  fastify.post("/armamento/cautela/encerrar", async (request, reply) => {
    const { militarId, senha, cautelaId } = request.body as any;

    const verifyStatus = await validatePassword(militarId, senha);

    if (verifyStatus === true) {
      await prisma.cautelaArmamento.update({
        where: {
          id: cautelaId,
        },
        data: {
          status: "inativo",
          data_fechamento_cautela: new Date(Date.now())
        },
      });
      return reply
        .status(200)
        .send({ message: "Senha correta, cautela encerrada!" });
    } else {
      return reply.status(205).send({ message: "Senha incorreta." });
    }
  });
}
