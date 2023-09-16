import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { Missao } from "../@types/types";

export async function missaoRoutes(fastify: FastifyInstance) {
fastify.post('/missao/create', async (request, reply) => {
    const { data_finalizacao, descricao, militar_destino, militar_origem } = request.body as Missao

    try {
      const result = await prisma.missao.create({
        data: {
            data_finalizacao,
            descricao,
            militar_destino,
            militar_origem
        },
      });
      return reply.status(201).send(result);
    } catch (error) {
      return reply.status(500).send(error)
    }
  })

  fastify.get('/missao', async (request, reply) => {
    const result = await prisma.missao.findMany({
      include: {
        militar: true
      }
    })

    return reply.status(200).send(result)
  })

  fastify.get('/missao/:id', async (request, reply) => {
    const { id } = request.params as any
    const result = await prisma.missao.findMany({
      where: {
        OR: [
          {militar_destino: id},
          {militar_origem: id}
        ]
      },
      include: {
        militar: true,
      }
    })

    return reply.status(200).send(result)
  })

}