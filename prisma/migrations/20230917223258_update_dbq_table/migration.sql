/*
  Warnings:

  - Added the required column `militarId` to the `Dbq` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Dbq" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "fotoDbq" TEXT,
    "fotoDocDbq" TEXT,
    "origem" TEXT,
    "destino" TEXT,
    "motivo" TEXT,
    "observacao" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "civilId" TEXT NOT NULL,
    "militarId" TEXT NOT NULL,
    CONSTRAINT "Dbq_civilId_fkey" FOREIGN KEY ("civilId") REFERENCES "Civil" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Dbq_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Dbq" ("civilId", "created_at", "destino", "fotoDbq", "fotoDocDbq", "id", "motivo", "observacao", "origem") SELECT "civilId", "created_at", "destino", "fotoDbq", "fotoDocDbq", "id", "motivo", "observacao", "origem" FROM "Dbq";
DROP TABLE "Dbq";
ALTER TABLE "new_Dbq" RENAME TO "Dbq";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
