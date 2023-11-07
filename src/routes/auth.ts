import { FastifyInstance } from "fastify";
import { prisma } from "../lib/prisma";
import { Militar } from "./militar";
import { validatePassword } from "../plugins/validatePassword";
import { convertDate } from "../utils/scripts";

export async function authRoutes(fastify: FastifyInstance) {

  fastify.post("/auth", async (request, reply) => {
    const { identidade, senha, ip } = request.body as Militar;
 
      const result = await prisma.militar.findUnique({
        where: {
          identidade,
        },
      });
      
      if (!result) {
        return reply.status(500).send({
          message: "Usuário não cadastrado.",
        });
      }
  
      const passwordValidate = await validatePassword(result.id, senha)
  
      if (!passwordValidate) {
        return reply.status(500).send({
          message: "Senha incorreta.",
        });
      }
  
  
      const token = fastify.jwt.sign(
        {
          ...result
        },
        {
          sub: result?.id,
        }
      );
  
      if (token && result) {
        const date = Date.now() + 1000*60*60*24*30;
        await prisma.session.create({
          data: {
            sessionToken: token,
            militarId: result?.id,
            ipAccess: ip ? String(ip) : "sem ip",
            expires: new Date(date),
          }
        })
        
      } 

    return { ...result, token};
  });

  fastify.post("/verifyToken", async (request ,reply) => {
      const { jwtToken } = request.body as any
      const result = await prisma.session.findUnique({
        where: {
          sessionToken: jwtToken as string,
        },
      })
      const expireDateSession = convertDate(String(result?.expires))
      const dateNow = convertDate(String(new Date()))

      if(dateNow > expireDateSession) {
        return reply.status(200).send(result)
      }else{
        return reply.status(205)
      }
    }
  );

  fastify.get("/sessions", async (request ,reply) => {
    const result = await prisma.session.findMany({
      include: {
        militar: true
      }
    })
    return reply.status(200).send(result)
  })

  fastify.get("/sessions/:id", async (request ,reply) => {
    const { id } = request.params as Militar
    const result = await prisma.session.findMany({
      where: {
        militarId: id
      },
      include: {
        militar: true
      }
    })
    return reply.status(200).send(result)
  })

  fastify.get(
    "/me/:id",
    async (request, reply) => {
      const { id } = request.params as any;
      let result = await prisma.militar.findUnique({
        where: {
          id,
        },
        include: {
          Funcao: true
        }
      });

      const token = fastify.jwt.sign(
        {
          ...result
        },
        {
          sub: result?.id,
          expiresIn: "7 days",
        }
      );
      return reply.send({ ...result, token });
    }
  );
}
