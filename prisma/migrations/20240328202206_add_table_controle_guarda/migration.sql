-- CreateTable
CREATE TABLE "ControleGuarda" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "entrada" DATETIME,
    "saida" DATETIME,
    "destino" TEXT,
    "militarServicoId" TEXT NOT NULL,
    "pessoaId" TEXT NOT NULL,
    CONSTRAINT "ControleGuarda_militarServicoId_fkey" FOREIGN KEY ("militarServicoId") REFERENCES "Militar" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "ControleGuarda_pessoaId_fkey" FOREIGN KEY ("pessoaId") REFERENCES "Militar" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "ControleGuarda_pessoaId_fkey" FOREIGN KEY ("pessoaId") REFERENCES "Civil" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
