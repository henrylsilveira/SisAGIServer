/*
  Warnings:

  - You are about to drop the column `pessoaId` on the `ControleGuarda` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_ControleGuarda" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "entrada" DATETIME,
    "saida" DATETIME,
    "destino" TEXT,
    "status" TEXT DEFAULT 'ativo',
    "militarServicoId" TEXT NOT NULL,
    "militarId" TEXT,
    "civilId" TEXT,
    CONSTRAINT "ControleGuarda_militarServicoId_fkey" FOREIGN KEY ("militarServicoId") REFERENCES "Militar" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "ControleGuarda_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "ControleGuarda_civilId_fkey" FOREIGN KEY ("civilId") REFERENCES "Civil" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_ControleGuarda" ("destino", "entrada", "id", "militarServicoId", "saida", "status") SELECT "destino", "entrada", "id", "militarServicoId", "saida", "status" FROM "ControleGuarda";
DROP TABLE "ControleGuarda";
ALTER TABLE "new_ControleGuarda" RENAME TO "ControleGuarda";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
