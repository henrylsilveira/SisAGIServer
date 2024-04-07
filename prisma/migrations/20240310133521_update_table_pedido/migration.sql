-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_PedidoViatura" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dataDesejada" DATETIME NOT NULL,
    "missao" TEXT NOT NULL,
    "intinerario" TEXT NOT NULL,
    "chefeViatura" TEXT NOT NULL,
    "motorista" TEXT,
    "dataDevolucao" DATETIME NOT NULL,
    "apresentar" TEXT NOT NULL,
    "observacao" TEXT NOT NULL DEFAULT '',
    "status" TEXT NOT NULL DEFAULT 'aguardando'
);
INSERT INTO "new_PedidoViatura" ("apresentar", "chefeViatura", "created_at", "dataDesejada", "dataDevolucao", "id", "intinerario", "missao", "motorista", "status") SELECT "apresentar", "chefeViatura", "created_at", "dataDesejada", "dataDevolucao", "id", "intinerario", "missao", "motorista", "status" FROM "PedidoViatura";
DROP TABLE "PedidoViatura";
ALTER TABLE "new_PedidoViatura" RENAME TO "PedidoViatura";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
