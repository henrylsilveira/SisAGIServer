import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { validatePassword } from "../plugins/validatePassword";
import { Militar } from './militar';
import { generateNowISOTime } from "../utils/scripts";

export interface CautelaProps {
  id: string;
  militarNome: string;
  materialId: string;
  observacao: string;
  quantidade: number;
  sub_unidade: string;
  dependencia: string;
  cautelouId: string;
  senha: string;
}

export async function cautelaRoutes(fastify: FastifyInstance) {
  fastify.get("/cautela", async (request, reply) => {
    const result = await prisma.cautela.findMany({
      include: {
        cautelou: true,
        material: true,
      },
    });

    return reply.status(200).send(result);
  });

  fastify.post("/cautela/create", async (request, reply) => {
    const { militarNome, materialId, observacao, quantidade, sub_unidade, dependencia, cautelouId, senha } =
      request.body as CautelaProps;

    if (senha) {
      if (await validatePassword(cautelouId, senha)) {
        const result = await prisma.cautela.create({
          data: {
            materialId,
            observacao,
            sub_unidade,
            quantidade,
            dependencia,
            resp_cautela: militarNome, 
            cautelouId,
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
        const result = await prisma.cautela.create({
            data: {
              materialId,
              observacao,
              sub_unidade,
              quantidade,
              dependencia,
              resp_cautela: militarNome, 
              cautelouId,
              validado: false,
            },
          });
          return reply.status(201).send(result);
    }
  });

  fastify.post("/cautela/validate", async (request, reply) => {
    const { militarId, senha, cautelaId } = request.body as any;

    const verifyStatus = await validatePassword(militarId, senha);

    if (verifyStatus === true) {
      await prisma.cautela.update({
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

  fastify.post("/cautela/encerrar", async (request, reply) => {
    const { militarId, senha, cautelaId } = request.body as any;

    const verifyStatus = await validatePassword(militarId, senha);

    if (verifyStatus === true) {
      await prisma.cautela.update({
        where: {
          id: cautelaId,
        },
        data: {
          status: "inativo",
          data_fechamento_cautela: generateNowISOTime()
        },
      });
      return reply
        .status(200)
        .send({ message: "Senha correta, cautela encerrada!" });
    } else {
      return reply.status(205).send({ message: "Senha incorreta." });
    }
  });

  fastify.get("/cautela/:id", async (request, reply) => {
    const { id } = request.params as Militar

    const result = await prisma.cautela.findMany({
      where: {
        cautelouId: id,
      },
      include: {
        cautelou: true,
        material: true,
      },
    })

    return reply.status(200).send(result);
  })
}
