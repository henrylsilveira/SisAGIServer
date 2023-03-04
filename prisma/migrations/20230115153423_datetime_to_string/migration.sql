-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Municao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nr_pedido" TEXT NOT NULL,
    "municao_pedida" INTEGER NOT NULL,
    "municao_usada" INTEGER,
    "municao_devolvida" INTEGER,
    "unidade" TEXT NOT NULL,
    "tipo_municao" TEXT NOT NULL,
    "data_instrucao" TEXT,
    "data_devolucao" TEXT,
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
