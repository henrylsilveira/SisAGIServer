import { FastifyInstance, FastifyRequest } from 'fastify';
import { prisma } from "../lib/prisma"
import bcrypt from 'bcrypt';
import { generateNowISOTime } from '../utils/scripts';

export type FuncaoMilitar = {
    id: string;
    funcao: string;
    created_at: Date;
    data_inicio:  Date;
    data_termino: Date;
    status: 'ativo' | 'inativo'
    militarId: string;
  }
  
  export type FuncaoMilitarArray = FuncaoMilitar[];


export async function funcaoRoutes(fastify: FastifyInstance) {


  fastify.get('/funcoes', async (request, reply) => {
    try {
      const result = await prisma.funcao.findMany({
        include: {
          militar: true
        },
        where: {
          status: 'ativo'
        }
      })

      return reply.status(201).send(result)
    } catch (error) {
      return reply.status(500).send(error);
    }
  })

    fastify.post('/funcao/deletar/:id', async (request, reply) => {
        const { id } = request.params as FuncaoMilitar
      
        try {
        const result = await prisma.funcao.delete({
           where: {
            id
           }
        })

        return reply.status(201).send(result)
      } catch (error) {
        return reply.status(500).send(error);
      }
    })

    fastify.post('/funcao/update/:id/:status', async (request, reply) => {
      const { id, status } = request.params as FuncaoMilitar
      console.log({ id, status })
      try {
      const result = await prisma.funcao.update({
         where: {
          id
         },
         data:{
          status,
          data_termino: generateNowISOTime()
         }
      })

      return reply.status(201).send(result)
    } catch (error) {
      return reply.status(500).send(error);
    }
  })
    
    fastify.post('/funcao/atribuir', async (request, reply) => {
        const { data_inicio, data_termino, militarId, funcao } = request.body as FuncaoMilitar
      
        try {
        const result = await prisma.funcao.create({
            data: {
                funcao,
                data_inicio,
                data_termino,
                status: 'ativo',
                militarId
            }
        })

        return reply.status(201).send(result)
      } catch (error) {
        return reply.status(500).send(error);
      }
    })

}