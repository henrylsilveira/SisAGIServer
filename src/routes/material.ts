import { FastifyInstance, FastifyRequest } from 'fastify';
import { prisma } from "../lib/prisma"
import bcrypt from 'bcrypt';

export interface MaterialProps {
  id: string;
  nome: string;
  condicoes: string;
  quantidade: number;
  local?: string;
  codigo?: string;
  subUnidade?: string;
  dependencia?: string;
  categoria?: string;
}

export async function materialRoutes(fastify: FastifyInstance) {

  fastify.get('/material', async (request, reply) => {
    const result = await prisma.material.findMany({
      include: {
        cautelas: true,
        _count: true
      }
    })

    return reply.status(200).send(result)
  })

  fastify.get('/material/:cia', async (request, reply) => {
    const { cia } = request.params as any

    const result = await prisma.material.findMany({
      where: {
        sub_unidade: cia
      },
      include: {
        cautelas: true,
        _count: true
      }
    })

    return reply.status(200).send(result)
  })

  fastify.post('/material/create', async (request, reply) => {
    const { nome, condicoes, quantidade, codigo, subUnidade: sub_unidade, dependencia, categoria } = request.body as MaterialProps

    try {
      const result = await prisma.material.create({
        data: {
          nome: nome.toUpperCase(),
          condicoes,
          quantidade,
          codigo,
          sub_unidade,
          dependencia,
          categoria
        },
      });
      return reply.status(201).send(result);
    } catch (error) {
      return reply.status(500).send(error)
    }
  })

  fastify.post('/material/update/:id', async (request, reply) => {
    const { id } = request.params as MaterialProps
    const { inputObject } = request.body as any
    console.log(inputObject)
    try {
      const result = await prisma.material.update({
        where: { id },
        data: {
          [inputObject.name]: inputObject.name === 'quantidade' ? Number(inputObject.value) : inputObject.value
        },
      });
      return reply.status(201).send(result);
    } catch (error) {
      return reply.status(500).send(error)
    }
  })

  fastify.post('/material/delete/:id', async (request, reply) => {
    const { id } = request.params as MaterialProps

    try {
      const result = await prisma.material.delete({
        where: { id }
      })

      return reply.status(200).send(result);
    } catch (error) {
      return reply.status(500).send(error)
    }

  })
}
