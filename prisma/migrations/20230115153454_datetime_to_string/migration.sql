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
    "data_missao" TEXT,
    "data_devolucao" TEXT,
    "missao" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "militarId" TEXT NOT NULL,
    CONSTRAINT "Combustivel_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Combustivel" ("combustivel_devolvido", "combustivel_pedido", "combustivel_usado", "companhia", "data_devolucao", "data_missao", "id", "militarId", "missao", "nr_pedido", "status", "tipo_combustivel", "unidade") SELECT "combustivel_devolvido", "combustivel_pedido", "combustivel_usado", "companhia", "data_devolucao", "data_missao", "id", "militarId", "missao", "nr_pedido", "status", "tipo_combustivel", "unidade" FROM "Combustivel";
DROP TABLE "Combustivel";
ALTER TABLE "new_Combustivel" RENAME TO "Combustivel";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
