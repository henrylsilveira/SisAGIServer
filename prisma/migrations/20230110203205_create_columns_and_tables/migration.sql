-- AlterTable
ALTER TABLE "Militar" ADD COLUMN "latitude" TEXT;
ALTER TABLE "Militar" ADD COLUMN "longitude" TEXT;

-- CreateTable
CREATE TABLE "Manutencao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tipoManutencao" TEXT NOT NULL,
    "dataManutencao" DATETIME NOT NULL,
    "armamentoId" TEXT NOT NULL,
    CONSTRAINT "Manutencao_armamentoId_fkey" FOREIGN KEY ("armamentoId") REFERENCES "Armamento" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "ArmamentoMilitar" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "armamentoId" TEXT NOT NULL,
    "militarId" TEXT NOT NULL,
    CONSTRAINT "ArmamentoMilitar_armamentoId_fkey" FOREIGN KEY ("armamentoId") REFERENCES "Armamento" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "ArmamentoMilitar_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Armamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "nr_serie" TEXT NOT NULL,
    "tipo" TEXT,
    "emprego" TEXT,
    "condicoes" TEXT,
    "local" TEXT,
    "dependencia" TEXT,
    "cabide" TEXT,
    "statusCautela" TEXT NOT NULL DEFAULT 'disponivel',
    "status" TEXT NOT NULL DEFAULT 'disponivel'
);
INSERT INTO "new_Armamento" ("cabide", "condicoes", "dependencia", "emprego", "id", "local", "nome", "nr_serie", "status", "tipo") SELECT "cabide", "condicoes", "dependencia", "emprego", "id", "local", "nome", "nr_serie", "status", "tipo" FROM "Armamento";
DROP TABLE "Armamento";
ALTER TABLE "new_Armamento" RENAME TO "Armamento";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
