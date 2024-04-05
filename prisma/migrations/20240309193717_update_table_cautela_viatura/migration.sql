-- RedefineTables
PRAGMA foreign_keys=OFF;
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
INSERT INTO "new_CautelaViatura" ("dataCautela", "dataEntrega", "id", "motorista", "pedidoViaturaId", "status", "viaturaId") SELECT "dataCautela", "dataEntrega", "id", "motorista", "pedidoViaturaId", "status", "viaturaId" FROM "CautelaViatura";
DROP TABLE "CautelaViatura";
ALTER TABLE "new_CautelaViatura" RENAME TO "CautelaViatura";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
