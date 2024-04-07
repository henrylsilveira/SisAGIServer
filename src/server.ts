import Fastify from "fastify";
import cors from "@fastify/cors";
import { authRoutes } from "./routes/auth";
import { militarRoutes } from "./routes/militar";
import { cautelaRoutes } from "./routes/cautela";
import { materialRoutes } from "./routes/material";
import jwt from "@fastify/jwt";
import { armamentoRoutes } from "./routes/armamento";
import { cautelaArmamentoRoutes } from "./routes/cautelaArmamento";
import { furrielRoutes } from "./routes/furriel";
import { funcaoRoutes } from "./routes/funcao";
import multer from 'fastify-multer'
import { avatarMilitar } from "./routes/avatarMilitar";
import fastifyStatic from '@fastify/static'
import path from "path";
import { missaoRoutes } from "./routes/missao";
import { civilRoutes } from "./routes/civil";
import { pmtRoutes } from "./routes/pmt";
import { cmtGda } from "./routes/cmtGda";

async function bootstrap() {
  
  const fastify = Fastify({
    logger: true,
  });

  await fastify.register(fastifyStatic, {
    root: path.join(__dirname, 'public' , 'imgAvatar'),
  })

  await fastify.register(multer.contentParser)

  await fastify.register(cors, {
    //COLOCAR O ENDEREÇO DO FRONT END PARA DIZENDO QUAL APP PODE FAZER REQUISIÇÃO ['http://siscau.vercel.app']
    origin: true
  });

  //Em produção troca o secret para uma variavel ambiente (criar um token)
  await fastify.register(jwt, {
    secret: `${process.env.SECRET_KEY_JWT}`,
  });
  
  //PMT
  await fastify.register(pmtRoutes)
  //MISSÕES
  await fastify.register(missaoRoutes);
  //AVARTARMILITAR
  await fastify.register(avatarMilitar);
  //FURRIEL
  await fastify.register(furrielRoutes);
  //MILITARES
  await fastify.register(militarRoutes);
  //CIVIL
  await fastify.register(civilRoutes);
  //FUNÇÕES
  await fastify.register(funcaoRoutes);
  //MATERIAL
  await fastify.register(cautelaRoutes);
  await fastify.register(materialRoutes);
  //ARMAMENTO
  await fastify.register(cautelaArmamentoRoutes);
  await fastify.register(armamentoRoutes);
  //AUTENTICAÇÃO
  await fastify.register(authRoutes);
  //CMT GDA
  await fastify.register(cmtGda);
  
  await fastify.listen({
    port: process.env.PORT ? Number(process.env.PORT) : 3333,
    // host: '0.0.0.0'
    // ("RENDER" in process.env) ? `0.0.0.0` : `localhost`
    // "3.134.238.10",
    //Retirar o host para executar o projeto localmente
  }).then(() => {
    console.log(`🚀 HTTP server running on ${process.env.PORT ? Number(process.env.PORT) : 3333}`)
  });
}

bootstrap();
