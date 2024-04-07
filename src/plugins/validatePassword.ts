import { prisma } from '../lib/prisma';
import bcrypt from 'bcrypt';

export async function validatePassword(idMilitar: string, senha: string) {
    const result = await prisma.militar.findUnique({
        where: {
            id: idMilitar,
        }
    })

    return bcrypt.compare(senha, result!.senha)
}