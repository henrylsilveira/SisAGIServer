import { FastifyInstance } from "fastify";
import multer from "fastify-multer";
import { multerConfig } from "../config/multer";
import { FastifyRequest } from "fastify/types/request";
import { prisma } from "../lib/prisma";
import { Militar } from "../@types/types";

interface RequestProps extends FastifyRequest {
    file?: any
}

export async function avatarMilitar(fastify: FastifyInstance) {

    fastify.post("/avatarMilitar/upload/:id", { preHandler: multer(multerConfig).single("avatarMilitar")}, async (request: RequestProps, reply) => {
        const { id } = request.params as Militar
        try {
            const result = await prisma.militar.update({
              where: { id },
              data: {
                avatar_url: request.file.filename
              }
            })
    
            return reply.status(201).send(result)
          } catch (error) {
            return reply.status(500).send(error);
          }
    })

    fastify.get("/avatarMilitar/avatar/:id", async (request, reply) => {
      const { id } = request.params as Militar
      try {
        const result = await prisma.militar.findUnique({
          where: { id }
        })

        return reply.status(200)
      } catch (error) {
        return reply.status(500).send(error);
      }
    } )
}
