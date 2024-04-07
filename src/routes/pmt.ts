import { FastifyInstance } from 'fastify';
import { prisma } from "../lib/prisma"
import { CautelaViatura, PedidoViatura, Viatura } from '../@types/types';


export async function pmtRoutes(fastify: FastifyInstance) {

    fastify.get('/veiculos',
    async (request, reply) => {
      const result = await prisma.viatura.findMany({
        include: {
          _count: true,
          CautelaViatura: true
        }
      })
  
      return reply.status(200).send(result)
    })

    fastify.put('/veiculo/update/status', async (request, reply) => {
      const { id, situacao } = request.body as Viatura

      try {
        const result = await prisma.viatura.update({
          where: {
            id
          },
          data: {
            situacao
          },
        });
        return reply.status(200).send(result);
      } catch (error) {
        return reply.status(500).send(error)
      }
    })

    fastify.put('/veiculo/update', async (request, reply) => {
      const { id, status, observacao } = request.body as PedidoViatura
      console.log({ id, status })
      try {
        const result = await prisma.pedidoViatura.update({
          where: {
            id
          },
          data: {
            status,
            observacao
          },
        });
        return reply.status(200).send(result);
      } catch (error) {
        return reply.status(500).send(error)
      }
    })
  
    fastify.post('/veiculo/create', async (request, reply) => {
      const { eb, tipo, tipoTransporte } = request.body as Viatura
      try {
        const result = await prisma.viatura.create({
          data: {
            eb,
            tipo,
            tipoTransporte
          },
        });
        return reply.status(201).send(result);
      } catch (error) {
        return reply.status(500).send(error)
      }
    })

    fastify.get('/veiculos/pedidos',
    async (request, reply) => {
      const result = await prisma.pedidoViatura.findMany({
        include: {
          _count: true,
          militar: true,
          CautelaViatura: true
        }
      })
      return reply.status(200).send(result)
    })

    fastify.put('/veiculos/pedidos/:id',
    async (request, reply) => {
      const { id } = request.params as PedidoViatura
      const result = await prisma.pedidoViatura.update({
        where: {
          id
        },
        data: {
          autorizado: true
        },
      });
      return reply.status(200).send(result)
    })

    fastify.get('/veiculos/pedidos/furriel/:companhia',
    async (request, reply) => {
      const { companhia } = request.params as { companhia: string}
      const result = await prisma.pedidoViatura.findMany({
        where: {
          companhia
        },
        include: {
          _count: true,
          militar: true,
          CautelaViatura: true
        }
      })
      return reply.status(200).send(result)
    })

    fastify.put('/veiculo/pedido/update', async (request, reply) => {
      const { id, status } = request.body as PedidoViatura
      try {
        const result = await prisma.pedidoViatura.update({
          where: {
            id
          },
          data: {
            status
          },
        });
        return reply.status(200).send(result);
      } catch (error) {
        return reply.status(500).send(error)
      }
    })

    fastify.put('/veiculo/pedido/descautela', async (request, reply) => {
      const { id, observacao, dataEntrega, pedidoViaturaId, viaturaId } = request.body as CautelaViatura
      console.log(request.body)
      try {
        const result = await prisma.cautelaViatura.update({
          where: {
            id
          },
          data: {
            dataEntrega,
            status: "finalizado",
            observacao
          },
        });

        await prisma.pedidoViatura.update({
          where:{
            id: pedidoViaturaId
          },
          data:{
            status: "finalizado"
          }
        })

        await prisma.viatura.update({
          where:{
            id: viaturaId
          },
          data:{
            situacao: "disponivel"
          }
        })
        return reply.status(200).send(result);
      } catch (error) {
        return reply.status(500).send(error)
      }
    })
  

    fastify.post('/veiculo/pedido/create', async (request, reply) => {
      const { apresentar, chefeViatura, dataDesejada, dataDevolucao, intinerario, missao, motorista, companhia, militarId } = request.body as PedidoViatura
      try {
        const result = await prisma.pedidoViatura.create({
          data: {
            companhia,
            militarIdPedido: militarId,
            apresentar,
            chefeViatura,
            dataDesejada,
            dataDevolucao,
            intinerario,
            missao,
            motorista
          },
        });
        return reply.status(201).send(result);
      } catch (error) {
        return reply.status(500).send(error)
      }
    })

    fastify.get('/veiculos/cautelas',
    async (request, reply) => {
      const result = await prisma.cautelaViatura.findMany({
        include: {
          viatura: true,
          pedido :true
        }
      })
  
      return reply.status(200).send(result)
    })

    fastify.post('/veiculo/cautela/create', async (request, reply) => {
      const { dataCautela, dataEntrega, viaturaId, pedidoViaturaId, motorista } = request.body as CautelaViatura
      console.log(request.body)
      try {
        const result = await prisma.cautelaViatura.create({
          data: {
            dataCautela,
            dataEntrega,
            pedidoViaturaId,
            viaturaId,
            motorista,
            status: "autorizado"
          },
        });

        await prisma.pedidoViatura.update({
          where:{
            id: pedidoViaturaId
          },
          data:{
            status: "autorizado"
          }
        })

        await prisma.viatura.update({
          where:{
            id: viaturaId
          },
          data:{
            situacao: "cautelado"
          }
        })
        return reply.status(201).send(result);
      } catch (error) {
        return reply.status(500).send(error)
      }
    })
  }