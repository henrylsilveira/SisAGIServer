import { FastifyInstance, FastifyRequest } from 'fastify';
import { prisma } from "../lib/prisma"
import { authenticate } from '../plugins/authenticate';

export interface Armamento {
  id: string;
  nome: string;
  nr_serie: string;
  tipo?: string;
  emprego?: string;
  condicoes?: string;
  companhia: string;
  cabide?: string;
  status: string;
}

export type Manutencao = {
  id: string;
  tipoManutencao: string;
  dataManutencao: string;
  armamentoId: string;
  armamemto: Armamento;
};

export type ManutencaoArray = Manutencao[]

export type VinculoArmamentoMilitar = {
  id: string;
  armamentoId: string;
  militarId: string;
}

export async function armamentoRoutes(fastify: FastifyInstance) {

  fastify.put("/armamento/dados", async (request, reply) => {
    const { id, name, value } = request.body as { name: string, value: string, id: string }

    try {
      await prisma.armamento.update({
        where: {
          id
        },
        data: {
          [name]: value
        }
      })
      return reply.status(201).send("Alterado com sucesso")
    } catch (error) {
      return reply.status(500).send(error)
    }

  })

  fastify.get('/armamentos/:companhia',
    async (request, reply) => {
      const { companhia } = request.params as Armamento

      try {
        const result = await prisma.armamento.findMany({
          where: {
            companhia
          },
          include: {
            cautelaArmamento: true,
            ArmamentoMilitar: true,
            Manutencao: true
          }
        })
        return reply.status(200).send(result)
      } catch (error) {
        return reply.status(500).send(error)
      }
    })

  fastify.get('/armamentos',
    async (request, reply) => {
      try {
        const result = await prisma.armamento.findMany({
          include: {
            cautelaArmamento: true,
            ArmamentoMilitar: true,
            Manutencao: true
          }
        })
        return reply.status(200).send(result)
      } catch (error) {
        return reply.status(500).send(error)
      }
    })

  fastify.get('/armamentos/nomes',
    async (request, reply) => {
      try {
        const result = await prisma.armamento.findMany({
          select: {
            nome: true
          }
        })
        return reply.status(200).send(result)
      } catch (error) {
        reply.status(500).send(error)
      }
    })

  fastify.post('/armamento/create', async (request, reply) => {
    const { nome, nr_serie, tipo, emprego, cabide, companhia, condicoes, status } = request.body as Armamento
    try {
      const result = await prisma.armamento.create({
        data: {
          nome: nome.toUpperCase(),
          condicoes,
          nr_serie,
          tipo,
          companhia,
          status,
          emprego,
          cabide
        },
      });
      return reply.status(201).send(result);
    } catch (error) {
      return reply.status(500).send(error)
    }
  })
  fastify.post('/armamento/manutencao/create', async (request, reply) => {
    const { tipoManutencao, dataManutencao, armamentoId } = request.body as Manutencao
    try {
      const result = await prisma.manutencao.create({
        data: {
          tipoManutencao,
          dataManutencao: new Date(Date.now()),
          armamentoId,
        },
      });
      return reply.status(201).send(result);
    } catch (error) {
      return reply.status(500).send(error)
    }
  })

  fastify.get('/armamentos/manutencao', async (request, reply) => {
    const result = await prisma.manutencao.findMany({
      include: {
        armamento: true
      }
    })

    return reply.status(200).send(result)
  })

  fastify.post('/armamento/vinculo/create', async (request, reply) => {
    const { armamentoId, militarId } = request.body as VinculoArmamentoMilitar
    try {
      const result = await prisma.armamentoMilitar.create({
        data: {
          armamentoId,
          militarId
        },
      });
      return reply.status(201).send(result);
    } catch (error) {
      return reply.status(500).send(error)
    }
  })

  fastify.get('/armamentos/viculados', async (request, reply) => {
    const result = await prisma.armamentoMilitar.findMany({
      include: {
        militar: true,
        armamento: true
      }
    })

    return reply.status(200).send(result)
  })

  fastify.get('/armamentos/viculados/:id', async (request, reply) => {
    const { id } = request.params as VinculoArmamentoMilitar

    const result = await prisma.armamentoMilitar.findMany({
      where: {
        militarId: id
      },
      include: {
        militar: true,
        armamento: true
      }
    })

    return reply.status(200).send(result)
  })

  fastify.delete('/armamentos/delete/viculo/:id', async (request, reply) => {
    const { id } = request.params as VinculoArmamentoMilitar
    await prisma.armamentoMilitar.delete({
      where: {
        id
      }
    })

    return reply.status(200).send('OK')
  })
}