/*
  Warnings:

  - Added the required column `local` to the `Armamento` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Armamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "nr_serie" TEXT NOT NULL,
    "tipo" TEXT,
    "emprego" TEXT,
    "condicoes" TEXT,
    "local" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'disponivel'
);
INSERT INTO "new_Armamento" ("condicoes", "emprego", "id", "nome", "nr_serie", "status", "tipo") SELECT "condicoes", "emprego", "id", "nome", "nr_serie", "status", "tipo" FROM "Armamento";
DROP TABLE "Armamento";
ALTER TABLE "new_Armamento" RENAME TO "Armamento";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
