/*
  Warnings:

  - You are about to drop the column `tipoViatura` on the `CautelaViatura` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_PedidoViatura" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dataDesejada" DATETIME NOT NULL,
    "missao" TEXT NOT NULL,
    "intinerario" TEXT NOT NULL,
    "tipoViatura" TEXT NOT NULL DEFAULT '',
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
CREATE TABLE "new_CautelaViatura" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "dataCautela" DATETIME NOT NULL,
    "dataEntrega" DATETIME NOT NULL,
    "motorista" TEXT NOT NULL,
    "observacao" TEXT NOT NULL DEFAULT '',
    "status" TEXT NOT NULL DEFAULT 'pendente',
    "viaturaId" TEXT NOT NULL,
    "pedidoViaturaId" TEXT NOT NULL,
    CONSTRAINT "CautelaViatura_viaturaId_fkey" FOREIGN KEY ("viaturaId") REFERENCES "Viatura" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "CautelaViatura_pedidoViaturaId_fkey" FOREIGN KEY ("pedidoViaturaId") REFERENCES "PedidoViatura" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_CautelaViatura" ("dataCautela", "dataEntrega", "id", "motorista", "observacao", "pedidoViaturaId", "status", "viaturaId") SELECT "dataCautela", "dataEntrega", "id", "motorista", "observacao", "pedidoViaturaId", "status", "viaturaId" FROM "CautelaViatura";
DROP TABLE "CautelaViatura";
ALTER TABLE "new_CautelaViatura" RENAME TO "CautelaViatura";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
