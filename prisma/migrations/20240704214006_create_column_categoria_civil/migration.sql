/*
  Warnings:

  - Added the required column `categoria` to the `Civil` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Civil" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "foto" TEXT,
    "fotoDoc" TEXT,
    "nomeCompleto" TEXT NOT NULL,
    "categoria" TEXT NOT NULL,
    "identidade" TEXT,
    "cpf" TEXT,
    "nomePai" TEXT,
    "nomeMae" TEXT,
    "profissao" TEXT,
    "dataNascimento" DATETIME,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO "new_Civil" ("cpf", "created_at", "dataNascimento", "foto", "fotoDoc", "id", "identidade", "nomeCompleto", "nomeMae", "nomePai", "profissao") SELECT "cpf", "created_at", "dataNascimento", "foto", "fotoDoc", "id", "identidade", "nomeCompleto", "nomeMae", "nomePai", "profissao" FROM "Civil";
DROP TABLE "Civil";
ALTER TABLE "new_Civil" RENAME TO "Civil";
CREATE UNIQUE INDEX "Civil_identidade_key" ON "Civil"("identidade");
CREATE UNIQUE INDEX "Civil_cpf_key" ON "Civil"("cpf");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
