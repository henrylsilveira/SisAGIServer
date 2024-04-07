/*
  Warnings:

  - You are about to drop the column `local` on the `Militar` table. All the data in the column will be lost.
  - You are about to drop the column `permissao` on the `Militar` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "FuncaoMilitar" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "funcao" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "militarId" TEXT NOT NULL,
    CONSTRAINT "FuncaoMilitar_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Municao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nr_pedido" TEXT NOT NULL,
    "municao_pedida" INTEGER NOT NULL,
    "municao_usada" INTEGER NOT NULL,
    "municao_devolvida" INTEGER NOT NULL,
    "unidade" TEXT NOT NULL,
    "tipo_municao" TEXT NOT NULL,
    "data_instrucao" DATETIME NOT NULL,
    "data_devolucao" DATETIME NOT NULL,
    "instrucao" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "militarId" TEXT NOT NULL,
    CONSTRAINT "Municao_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Combustivel" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nr_pedido" TEXT NOT NULL,
    "combustivel_pedido" INTEGER NOT NULL,
    "combustivel_usado" INTEGER NOT NULL,
    "combustivel_devolvido" INTEGER NOT NULL,
    "unidade" TEXT NOT NULL,
    "tipo_combustivel" TEXT NOT NULL,
    "data_missao" DATETIME NOT NULL,
    "data_devolucao" DATETIME NOT NULL,
    "missao" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "militarId" TEXT NOT NULL,
    CONSTRAINT "Combustivel_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Militar" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "identidade" TEXT NOT NULL,
    "nome_completo" TEXT NOT NULL,
    "nome_guerra" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "companhia" TEXT,
    "pelotao" TEXT,
    "funcao_local" TEXT NOT NULL DEFAULT 'comum',
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "longitude" TEXT,
    "latitude" TEXT
);
INSERT INTO "new_Militar" ("funcao_local", "id", "identidade", "latitude", "longitude", "nome_completo", "nome_guerra", "pelotao", "senha", "status") SELECT "funcao_local", "id", "identidade", "latitude", "longitude", "nome_completo", "nome_guerra", "pelotao", "senha", "status" FROM "Militar";
DROP TABLE "Militar";
ALTER TABLE "new_Militar" RENAME TO "Militar";
CREATE UNIQUE INDEX "Militar_identidade_key" ON "Militar"("identidade");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
