/*
  Warnings:

  - You are about to drop the column `tipoViatura` on the `PedidoViatura` table. All the data in the column will be lost.

*/
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
    "status" TEXT NOT NULL DEFAULT 'aguardando',
    "companhia" TEXT NOT NULL DEFAULT '',
    "autorizado" BOOLEAN NOT NULL DEFAULT false,
    "militarIdPedido" TEXT NOT NULL DEFAULT '',
    CONSTRAINT "PedidoViatura_militarIdPedido_fkey" FOREIGN KEY ("militarIdPedido") REFERENCES "Militar" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_PedidoViatura" ("apresentar", "autorizado", "chefeViatura", "companhia", "created_at", "dataDesejada", "dataDevolucao", "id", "intinerario", "militarIdPedido", "missao", "motorista", "observacao", "status") SELECT "apresentar", "autorizado", "chefeViatura", "companhia", "created_at", "dataDesejada", "dataDevolucao", "id", "intinerario", "militarIdPedido", "missao", "motorista", "observacao", "status" FROM "PedidoViatura";
DROP TABLE "PedidoViatura";
ALTER TABLE "new_PedidoViatura" RENAME TO "PedidoViatura";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
