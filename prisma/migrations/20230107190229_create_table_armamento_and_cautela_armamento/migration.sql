-- CreateTable
CREATE TABLE "CautelaArmamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "data_cautela" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observacao" TEXT NOT NULL,
    "local" TEXT NOT NULL,
    "validado" BOOLEAN NOT NULL,
    "resp_cautela" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "cautelouId" TEXT NOT NULL,
    "armamentoId" TEXT NOT NULL,
    CONSTRAINT "CautelaArmamento_cautelouId_fkey" FOREIGN KEY ("cautelouId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "CautelaArmamento_armamentoId_fkey" FOREIGN KEY ("armamentoId") REFERENCES "Armamento" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Armamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "nr_serie" TEXT NOT NULL,
    "tipo" TEXT,
    "emprego" TEXT,
    "condicoes" TEXT,
    "status" TEXT NOT NULL DEFAULT 'disponível'
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Material" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "condicoes" TEXT,
    "quantidade" INTEGER,
    "local" TEXT NOT NULL,
    "codigo" TEXT,
    "sub_unidade" TEXT,
    "dependencia" TEXT,
    "categoria" TEXT
);
INSERT INTO "new_Material" ("categoria", "codigo", "condicoes", "dependencia", "id", "local", "nome", "quantidade", "sub_unidade") SELECT "categoria", "codigo", "condicoes", "dependencia", "id", "local", "nome", "quantidade", "sub_unidade" FROM "Material";
DROP TABLE "Material";
ALTER TABLE "new_Material" RENAME TO "Material";
CREATE UNIQUE INDEX "Material_nome_key" ON "Material"("nome");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
