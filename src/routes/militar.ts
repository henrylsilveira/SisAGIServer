import { FastifyInstance, FastifyRequest } from 'fastify';
import { prisma } from "../lib/prisma"
import bcrypt from 'bcrypt';

export interface Militar {
  //DADOS BÁSICOS
  id: string;
  ip: string;
  identidade: string;
  postoGrad: string;
  nomeCompleto: string;
  nomeGuerra: string;
  senha: string;
  companhia?: string;
  pelotao?: string;
  funcao_local: string;
  status: 'ativo' | 'encostado' | 'baixado' | 'adido' | 'incapaz' | 'inativo';
  //DADOS COMPLEMENTARES
  cpf?: string; 
  nome_pai?: string;
  nome_mae?: string;
  naturalidade?: string;
  data_nascimento?: Date;	
  data_praca?: Date;	
  qmg_qmp?: string;	
  sexo?: string;
  cidade?: string;
  estado?: string;
  bairro?: string;
  nr_rua?: string;	
  complemento?: string;
  cep?: string;
  telefone?: string;
  email?: string;
  cargo_qcp?: string;	
  tipo_sanguineo?: string;
  prec_cp?: string;
  local_cumpre_expediente?: string;	
  motocarro?: string;
  hab_militar?: string;
  //GEOLOCALIZAÇÃO
  longitude?: string;
  latitude?: string;
}

export async function militarRoutes(fastify: FastifyInstance) {

    fastify.get('/militar', async (request, reply) => {
      try {
        const result = await prisma.militar.findMany({
          include: {
            Funcao: true
          }
        })

        return reply.status(200).send(result)
      } catch (error) {
        return reply.status(500).send(error);
      }
    })

    fastify.post('/militar/dados', async (request, reply) => {
      const { id, name , value } = request.body as {id: string, name: string, value: string}
      try {
        const result = await prisma.militar.update({
          where: { id },
          data: {
            [name]: value
          }
        })

        return reply.status(201).send(result)
      } catch (error) {
        return reply.status(500).send(error);
      }
    })

    fastify.get('/militar/:id', async (request, reply) => {
      const { id } = request.params as any
      try {
        const result = await prisma.militar.findUnique({
          where:{
            id
          },
          include: {
            ArmamentoMilitar: true,
            CautelaArmamento: true,
            cautelas: true,
            Funcao: true,
            Combustivel: true,
            Municao: true,
            Session: true,
            _count: true,
          }
        })

        return reply.status(200).send(result)
      } catch (error) {
        return reply.status(500).send(error);
      }
    })

    fastify.post('/militar/create', async (request, reply) => {
        const { identidade, nomeCompleto: nome_completo, nomeGuerra: nome_guerra, senha, companhia, pelotao, postoGrad: post_grad } = request.body as Militar
        try {

            const find = await prisma.militar.findUnique({
              where: {
                identidade
              }
            })
            if(find) {
              return reply.status(205).send({
                message: 'Identidade já cadastrada.'
              });
            }
            const result = await prisma.militar.create({
              data: {
                nome_completo,
                nome_guerra,
                post_grad,
                identidade: String(identidade),
                senha: String(await bcrypt.hash(senha, 10)),
                companhia,
                pelotao,
              },
            });
            const today = new Date();

            const resultFuncao = await prisma.funcao.create({
              data: {
                funcao: 'comum',
                data_inicio: today.toISOString(),
                data_termino: today.toISOString(),
                militarId: result.id
              },
            });
            return reply.status(201).send({...result, ...resultFuncao});
          } catch (error) {
            return reply.status(500).send(error);
          }
    })

    fastify.patch('/militar/:id', async (request, reply) => {
      const { id } = request.params as Militar
      const { senha } = request.body as Militar
      console.table(senha)
      try {
        const result = await prisma.militar.update({
          where: { id },
          data: {
            senha: String(await bcrypt.hash(senha, 10))
          }
        })

        return reply.status(201).send(result)
      } catch (error) {
        return reply.status(500).send(error);
      }
    })
}