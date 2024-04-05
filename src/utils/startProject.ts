
import bcrypt from 'bcrypt';
import { prisma } from '../lib/prisma';
//CREATE ADMIN USER
async function createAdminUser(){
    const idAdmin = "0000000000"
    const senha = "ce5e75ce32dd96d8954591ce020e97a1" //"sisagi" hash md5
    const result = await prisma.militar.findUnique({
        where: {
          identidade: idAdmin,
        },
      });

      if(result){
        console.clear()
        return console.log("%c Super Admin já foi criado!", "color:red; background-color:black")
      }

      const resultCreate = await prisma.militar.create({
        data: {
          nome_completo: "Administrador",
          nome_guerra: "Admin",
          post_grad: "CEL",
          identidade: "0000000000",
          senha: String(await bcrypt.hash(senha, 10)),
          companhia: "EM",
          pelotao: "SEC CMDO",
        },
      });
      const today = new Date();

      await prisma.funcao.create({
        data: {
          funcao: 'super admin',
          data_inicio: today.toISOString(),
          data_termino: today.toISOString(),
          militarId: resultCreate.id
        },
      });
      console.clear()
      console.log("%c Conta Adminstrador criada com sucesso! Não perca essas credenciais!", 'color:green')
      return console.table([{Usuario: idAdmin,Senha: senha}])
}
createAdminUser()