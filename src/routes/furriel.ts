import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";

export type Municao = {
    id: string;
    nrPedido: string;
    municaoPedida: number;
    municaoUsada?: number;
    municaoDevolvida?: number;
    unidade: string;
    companhia: string;
    tipoMunicao: string;
    dataInstrucao: string;
    data_devolucao?: string;
    instrucao?: string;
    status: string;
    militarId: string;
  };
  
  export type Combustivel = {
    id: string;
    nr_pedido: string;
    combustivel_pedido: number;
    combustivel_usado: number;
    combustivel_devolvido: number;
    unidade: string;
    companhia: string;
    tipo_combustivel: string;
    data_missao: string;
    data_devolucao: string;
    missao: string;
    status: string;
    militar: string;
  };

export async function furrielRoutes(fastify: FastifyInstance) {
    fastify.get('/municao',
  // {
  //     onRequest: [authenticate],
  //   },
  async (request, reply) => {
    const result = await prisma.municao.findMany({
      include: {
        militar: true,
      }
    })
    return reply.status(200).send(result)
  })

  fastify.get('/combustivel',
  // {
  //     onRequest: [authenticate],
  //   },
  async (request, reply) => {
    const result = await prisma.combustivel.findMany({
      include: {
        militar: true,
      }
    })
    return reply.status(200).send(result)
  })

  fastify.post('/furriel/municao/create', async (request, reply) => {
    const { companhia, instrucao, dataInstrucao, tipoMunicao, unidade, municaoPedida, nrPedido, militarId } = request.body as Municao

    try {
      const result = await prisma.municao.create({
        data: {
            companhia,
            instrucao,
            data_instrucao: dataInstrucao,
            tipo_municao: tipoMunicao,
            unidade,
            municao_pedida: municaoPedida,
            nr_pedido: nrPedido,
            militarId,
          },
      });
      return reply.status(201).send(result);
    } catch (error) {
      return reply.status(500).send(error)
    }
  })

  fastify.post('/furriel/municao/encerrar', async (request, reply) => {
    const { id, municaoDevolvida, municaoUsada, data_devolucao } = request.body as Municao

    try {
      const result = await prisma.municao.update({
        where: {
          id
        },
        data: {
            municao_devolvida: municaoDevolvida,
            municao_usada: municaoUsada,
            data_devolucao,
            status: 'fechado'
          },
      });
      return reply.status(201).send(result);
    } catch (error) {
      return reply.status(500).send(error)
    }
  })

//   fastify.post('/furriel/combustivel/create', async (request, reply) => {
//     const { nome, nr_serie, tipo, emprego, cabide, local, condicoes, status } = request.body as Combustivel
//     console.log(request.body)
//     try {
//       const result = await prisma.armamento.create({
//         data: {
//           nome: nome.toUpperCase(),
//           condicoes,
//           nr_serie,
//           tipo,
//           local,
//           status,
//           emprego,
//           cabide
//         },
//       });
//       return reply.status(201).send(result);
//     } catch (error) {
//       return reply.status(500).send(error)
//     }
//   })
}