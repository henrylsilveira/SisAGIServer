/*
  Warnings:

  - Added the required column `companhia` to the `Municao` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Municao" (
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
    "companhia" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "militarId" TEXT NOT NULL,
    CONSTRAINT "Municao_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Municao" ("data_devolucao", "data_instrucao", "id", "instrucao", "militarId", "municao_devolvida", "municao_pedida", "municao_usada", "nr_pedido", "status", "tipo_municao", "unidade") SELECT "data_devolucao", "data_instrucao", "id", "instrucao", "militarId", "municao_devolvida", "municao_pedida", "municao_usada", "nr_pedido", "status", "tipo_municao", "unidade" FROM "Municao";
DROP TABLE "Municao";
ALTER TABLE "new_Municao" RENAME TO "Municao";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
