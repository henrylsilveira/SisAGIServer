/*
  Warnings:

  - You are about to alter the column `data_devolucao` on the `Combustivel` table. The data in that column could be lost. The data in that column will be cast from `String` to `DateTime`.
  - You are about to alter the column `data_missao` on the `Combustivel` table. The data in that column could be lost. The data in that column will be cast from `String` to `DateTime`.
  - You are about to alter the column `data_devolucao` on the `Municao` table. The data in that column could be lost. The data in that column will be cast from `String` to `DateTime`.
  - You are about to alter the column `data_instrucao` on the `Municao` table. The data in that column could be lost. The data in that column will be cast from `String` to `DateTime`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Combustivel" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nr_pedido" TEXT NOT NULL,
    "combustivel_pedido" INTEGER NOT NULL,
    "combustivel_usado" INTEGER NOT NULL,
    "combustivel_devolvido" INTEGER NOT NULL,
    "unidade" TEXT NOT NULL,
    "companhia" TEXT NOT NULL,
    "tipo_combustivel" TEXT NOT NULL,
    "data_missao" DATETIME,
    "data_devolucao" DATETIME,
    "missao" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "militarId" TEXT NOT NULL,
    CONSTRAINT "Combustivel_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Combustivel" ("combustivel_devolvido", "combustivel_pedido", "combustivel_usado", "companhia", "data_devolucao", "data_missao", "id", "militarId", "missao", "nr_pedido", "status", "tipo_combustivel", "unidade") SELECT "combustivel_devolvido", "combustivel_pedido", "combustivel_usado", "companhia", "data_devolucao", "data_missao", "id", "militarId", "missao", "nr_pedido", "status", "tipo_combustivel", "unidade" FROM "Combustivel";
DROP TABLE "Combustivel";
ALTER TABLE "new_Combustivel" RENAME TO "Combustivel";
CREATE TABLE "new_Municao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nr_pedido" TEXT NOT NULL,
    "municao_pedida" INTEGER NOT NULL,
    "municao_usada" INTEGER,
    "municao_devolvida" INTEGER,
    "unidade" TEXT NOT NULL,
    "tipo_municao" TEXT NOT NULL,
    "data_instrucao" DATETIME,
    "data_devolucao" DATETIME,
    "instrucao" TEXT,
    "companhia" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "militarId" TEXT NOT NULL,
    CONSTRAINT "Municao_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Municao" ("companhia", "data_devolucao", "data_instrucao", "id", "instrucao", "militarId", "municao_devolvida", "municao_pedida", "municao_usada", "nr_pedido", "status", "tipo_municao", "unidade") SELECT "companhia", "data_devolucao", "data_instrucao", "id", "instrucao", "militarId", "municao_devolvida", "municao_pedida", "municao_usada", "nr_pedido", "status", "tipo_municao", "unidade" FROM "Municao";
DROP TABLE "Municao";
ALTER TABLE "new_Municao" RENAME TO "Municao";
CREATE UNIQUE INDEX "Municao_nr_pedido_key" ON "Municao"("nr_pedido");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
