import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";

export async function feedbackRoutes(fastify: FastifyInstance ){
    // fastify.post("/feedback/upload/:id", { preHandler: multer(multerConfig).single("avatarMilitar")}, async (request: RequestProps, reply) => {
    //     const { id } = request.params as any
    //     try {
    //         const result = await prisma.feedback.update({
    //           where: { id },
    //           data: {
    //             avatar_url: request.file.filename
    //           }
    //         })
    
    //         return reply.status(201).send(result)
    //       } catch (error) {
    //         return reply.status(500).send(error);
    //       }
    // })
    fastify.get("/feedback", async(request, reply) => {
        const result = await prisma
    })
}