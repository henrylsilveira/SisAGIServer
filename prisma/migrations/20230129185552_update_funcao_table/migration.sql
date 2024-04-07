-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Funcao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "funcao" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "data_inicio" DATETIME NOT NULL,
    "data_termino" DATETIME NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "militarId" TEXT NOT NULL,
    CONSTRAINT "Funcao_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Funcao" ("data_inicio", "data_termino", "funcao", "id", "militarId", "status") SELECT "data_inicio", "data_termino", "funcao", "id", "militarId", "status" FROM "Funcao";
DROP TABLE "Funcao";
ALTER TABLE "new_Funcao" RENAME TO "Funcao";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
