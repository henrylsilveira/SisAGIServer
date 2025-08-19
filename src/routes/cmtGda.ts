import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { generateNowISOTime } from "../utils/scripts";

export async function cmtGda(fastify: FastifyInstance) {
  fastify.post("/controleGuarda/registrar/entrada/militar", async (request, reply) => {
    const { militarId, militarServicoId, status } = request.body as any

    try {
      if (status === "entrada") {
        const result = await prisma.controleGuarda.create({
          data: {
            entrada: generateNowISOTime(),
            militarServicoId,
            militarId,
            status: "ativo"
          }
        })
        return reply.status(201).send(result)
      } else {
        const result = await prisma.controleGuarda.create({
          data: {
            saida: generateNowISOTime(),
            militarServicoId,
            militarId,
          }
        })
        return reply.status(201).send(result)
      }
    } catch (error) {
      return reply.status(500).send(error);
    }
  })

  fastify.post("/controleGuarda/registrar/entrada/civil", async (request, reply) => {
    const { civilId, militarServicoId, status } = request.body as any

    try {
      if (status === "entrada") {
        const result = await prisma.controleGuarda.create({
          data: {
            entrada: generateNowISOTime(),
            militarServicoId,
            civilId,
            status: "ativo"
          }
        })
        return reply.status(201).send(result)
      } else {
        const result = await prisma.controleGuarda.create({
          data: {
            saida: generateNowISOTime(),
            militarServicoId,
            civilId,
          }
        })
        return reply.status(201).send(result)
      }
    } catch (error) {
      return reply.status(500).send(error);
    }
  })

  fastify.put("/controleGuarda/update/:id/:status", async (request, reply) => {
    const { id, status } = request.params as any
    try {
      if (status === "entrada") {
        const result = await prisma.controleGuarda.update({
          where: {
            id
          },
          data: {
            entrada: generateNowISOTime(),
            status: "finalizado"
          }

        })
        return reply.status(201).send(result)
      } else if (status === "saida") {
        const result = await prisma.controleGuarda.update({
          where: {
            id
          },
          data: {
            saida: generateNowISOTime(),
            status: "finalizado"
          }

        })
        return reply.status(201).send(result)
      } else {
        const result = await prisma.controleGuarda.update({
          where: {
            id
          },
          data: {
            status: "finalizado"
          }

        })
        return reply.status(201).send(result)
      }
    } catch (error) {
      return reply.status(500).send(error);
    }
  })

  fastify.put("/controleGuarda/update/:id", async (request, reply) => {
    const { id } = request.params as any
    const { destino } = request.body as any
    try {
      const result = await prisma.controleGuarda.update({
        where: {
          id
        },
        data: {
          destino
        }

      })
      return reply.status(201).send(result)

    } catch (error) {
      return reply.status(500).send(error);
    }
  })

  fastify.get("/controGuarda/registros", async (request, reply) => {
    try {
      const result = await prisma.controleGuarda.findMany({
        include: {
          civil: true,
          militar: true,
          militarServico: true
        }
      })

      return reply.status(200).send(result)
    } catch (error) {
      return reply.status(500).send(error);
    }
  })
  fastify.get("/controGuarda/registros/:status", async (request, reply) => {
    const { status } = request.params as {status: "ativo" | "finalizado"}
    try {
      const result = await prisma.controleGuarda.findMany({
        where: {
          status
        },
        orderBy: {
          entrada: "desc"
        },
        include: {
          civil: true,
          militar: true,
          militarServico: true
        }
      })

      return reply.status(200).send(result)
    } catch (error) {
      return reply.status(500).send(error);
    }
  })
  fastify.get("/controGuarda/registros/:id/militar", async (request, reply) => {
    const { id } = request.params as {id: string}
    try {
      const result = await prisma.controleGuarda.findMany({
        where: {
          militarId: id,
          status: "ativo"
        }
      })

      return reply.status(200).send(result)
    } catch (error) {
      return reply.status(500).send(error);
    }
  })
  fastify.get("/controGuarda/registros/relatorio/:start/:end", async (request, reply) => {
    const { start, end } = request.params as {start: string; end: string}
    // #TODO: TALVEZ TENHA QUE CORRIGIR O TIPO DA TABELA PARA NUMBER E NAO DATETIME
    try {
      const result = await prisma.controleGuarda.findMany({
        where: {
          entrada: {
            gte: start
          },
          AND:{
            saida:{
              lte: end
            }
          }
        }
      })

      return reply.status(200).send(result)
    } catch (error) {
      return reply.status(500).send(error);
    }
  })
}