import { FastifyInstance, FastifyRequest } from "fastify";
import { prisma } from "../lib/prisma";
import multer from "fastify-multer";
import { multerConfig } from "../config/multer";
import { Civil } from "../@types/types";
import { Dbq } from "@prisma/client";
import { convertDateInputToISODate } from "../utils/scripts";

interface RequestProps extends FastifyRequest {
  file?: any
}

export async function civilRoutes(fastify: FastifyInstance) {
  fastify.post("/civil/create", async (request: RequestProps, reply) => {
    const {
      nomeCompleto,
      identidade,
      dataNascimento,
      categoria,
      cpf,
      nomePai,
      nomeMae,
      profissao,
    } = request.body as Civil

    const result = await prisma.civil.findMany({
      where: {
        OR: [
          { cpf },
          { identidade },
          { nomeCompleto: nomeCompleto.toLowerCase() }
        ]
      }
    });

    if (!result[0]) {
      try {
        const civil = await prisma.civil.create({
          data: {
            nomeCompleto: nomeCompleto.toLowerCase(),
            identidade,
            categoria,
            dataNascimento: convertDateInputToISODate(dataNascimento),
            cpf,
            nomeMae,
            nomePai,
            profissao
          }
        })

        return reply.status(201).send({civil})
      } catch (error) {
        return reply.status(500).send({message: "Erro ao cadastrar o civil."})
      }
    } else {
      return reply.status(500).send({message: "Civil já cadastrado"})
    }
  })
  fastify.get("/civil", async (request, reply) => {
    try {
      const result = await prisma.civil.findMany();

      return reply.status(201).send(result);
    } catch (error) {
      return reply.status(500).send(error)
    }

  })
  fastify.get("/civil/:search", async (request, reply) => {
    const { search } = request.params as any;
    try {
      const result = await prisma.civil.findMany({
        where: {
          OR: [
            { cpf: search },
            { identidade: search },
            { nomeCompleto: search.toLowerCase() }
          ]
        }
      });

      return reply.status(201).send(result);
    } catch (error) {
      return reply.status(500).send(error)
    }

  })

  fastify.get("/civil/dbq/:id", async (request, reply) => {
    const { id } = request.params as any;
    try {
      const result = await prisma.dbq.findMany({
        where: {
         militarId: id
        },
        include: {
          civil: true
        },
        take: 5
      });

      return reply.status(201).send(result);
    } catch (error) {
      return reply.status(500).send(error)
    }

  })

  fastify.post("/civil/dbq/create", async (request: RequestProps, reply) => {
    const {
      nomeCompleto,
      identidade,
      cpf,
      nomePai,
      dataNascimento,
      nomeMae,
      origem,
      destino,
      profissao,
      motivo,
      observacao,
      militarId
    } = request.body as any
    console.log(request.body)
    const result = await prisma.civil.findMany({
      where: {
        OR: [
          { cpf },
          { identidade },
          { nomeCompleto: nomeCompleto.toLowerCase() }
        ]
      }
    });
    if (!result[0]) {
      try {
        const civil = await prisma.civil.create({
          data: {
            nomeCompleto: nomeCompleto.toLowerCase(),
            dataNascimento: convertDateInputToISODate(dataNascimento),
            identidade,
            categoria: "civil",
            cpf,
            nomeMae,
            nomePai,
            profissao
          }
        })
        const dbq = await prisma.dbq.create({
          data: {
            origem,
            destino,
            motivo,
            observacao,
            civilId: civil.id,
            militarId
          }
        })

        return reply.status(201).send({civil, dbq})
      } catch (error) {
        return reply.status(500).send(error)
      }
    } else {
      const civil = result[0]
      try {
        const dbq = await prisma.dbq.create({
          data: {
            origem,
            destino,
            motivo,
            observacao,
            civilId: civil.id,
            militarId
          }
        })
        return reply.status(201).send({civil, dbq});
      } catch (error) {
        return reply.status(500).send(error)
      }
    }
  })

  fastify.post("/civil/upload/fotoCivil/:id", { preHandler: multer(multerConfig).single("fotoCivil") }, async (request: RequestProps, reply) => {
    const { id } = request.params as Civil
    try {
      const result = await prisma.civil.update({
        where: { id },
        data: {
          foto: request.file.filename
        }
      })

      return reply.status(201).send(result)
    } catch (error) {
      return reply.status(500).send(error);
    }
  })

  fastify.post("/civil/upload/fotoDbq/:id", { preHandler: multer(multerConfig).single("fotoDbq") }, async (request: RequestProps, reply) => {
    const { id } = request.params as Dbq
    try {
      const result = await prisma.dbq.update({
        where: { id },
        data: {
          fotoDbq: request.file.filename
        }
      })

      return reply.status(201).send(result)
    } catch (error) {
      return reply.status(500).send(error);
    }
  })

  fastify.post("/civil/upload/fotoDocDbq/:id", { preHandler: multer(multerConfig).single("fotoDocDbq") }, async (request: RequestProps, reply) => {
    const { id } = request.params as Dbq
    try {
      const result = await prisma.dbq.update({
        where: { id },
        data: {
          fotoDocDbq: request.file.filename
        }
      })

      return reply.status(201).send(result)
    } catch (error) {
      return reply.status(500).send(error);
    }
  })

  fastify.post("/civil/upload/fotoDoc/:id", { preHandler: multer(multerConfig).single("fotoDoc") }, async (request: RequestProps, reply) => {
    const { id } = request.params as Civil
    try {
      const result = await prisma.civil.update({
        where: { id },
        data: {
          fotoDoc: request.file.filename
        }
      })

      return reply.status(201).send(result)
    } catch (error) {
      return reply.status(500).send(error);
    }
  })
}