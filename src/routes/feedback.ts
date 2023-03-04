import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";

export async function feedbackRoutes(fastify: FastifyInstance ){
    fastify.get("/feedbacks", async(request, reply) => {
        const result = await prisma
    })
}