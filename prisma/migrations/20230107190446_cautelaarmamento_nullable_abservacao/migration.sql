-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_CautelaArmamento" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "data_cautela" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observacao" TEXT,
    "local" TEXT NOT NULL,
    "validado" BOOLEAN NOT NULL,
    "resp_cautela" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "cautelouId" TEXT NOT NULL,
    "armamentoId" TEXT NOT NULL,
    CONSTRAINT "CautelaArmamento_cautelouId_fkey" FOREIGN KEY ("cautelouId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "CautelaArmamento_armamentoId_fkey" FOREIGN KEY ("armamentoId") REFERENCES "Armamento" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_CautelaArmamento" ("armamentoId", "cautelouId", "data_cautela", "id", "local", "observacao", "resp_cautela", "status", "validado") SELECT "armamentoId", "cautelouId", "data_cautela", "id", "local", "observacao", "resp_cautela", "status", "validado" FROM "CautelaArmamento";
DROP TABLE "CautelaArmamento";
ALTER TABLE "new_CautelaArmamento" RENAME TO "CautelaArmamento";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
