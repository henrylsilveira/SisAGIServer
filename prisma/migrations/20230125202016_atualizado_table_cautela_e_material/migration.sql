/*
  Warnings:

  - You are about to drop the column `companhia` on the `Cautela` table. All the data in the column will be lost.
  - You are about to drop the column `companhia` on the `Material` table. All the data in the column will be lost.
  - Added the required column `dependencia` to the `Cautela` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sub_unidade` to the `Cautela` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Cautela" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "data_cautela" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observacao" TEXT NOT NULL,
    "sub_unidade" TEXT NOT NULL,
    "dependencia" TEXT NOT NULL,
    "validado" BOOLEAN NOT NULL,
    "resp_cautela" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "data_fechamento_cautela" DATETIME,
    "cautelouId" TEXT NOT NULL,
    "materialId" TEXT NOT NULL,
    CONSTRAINT "Cautela_cautelouId_fkey" FOREIGN KEY ("cautelouId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Cautela_materialId_fkey" FOREIGN KEY ("materialId") REFERENCES "Material" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Cautela" ("cautelouId", "data_cautela", "data_fechamento_cautela", "id", "materialId", "observacao", "resp_cautela", "status", "validado") SELECT "cautelouId", "data_cautela", "data_fechamento_cautela", "id", "materialId", "observacao", "resp_cautela", "status", "validado" FROM "Cautela";
DROP TABLE "Cautela";
ALTER TABLE "new_Cautela" RENAME TO "Cautela";
CREATE TABLE "new_Material" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "condicoes" TEXT,
    "quantidade" INTEGER,
    "codigo" TEXT,
    "sub_unidade" TEXT,
    "dependencia" TEXT,
    "categoria" TEXT
);
INSERT INTO "new_Material" ("categoria", "codigo", "condicoes", "dependencia", "id", "nome", "quantidade", "sub_unidade") SELECT "categoria", "codigo", "condicoes", "dependencia", "id", "nome", "quantidade", "sub_unidade" FROM "Material";
DROP TABLE "Material";
ALTER TABLE "new_Material" RENAME TO "Material";
CREATE UNIQUE INDEX "Material_nome_key" ON "Material"("nome");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
