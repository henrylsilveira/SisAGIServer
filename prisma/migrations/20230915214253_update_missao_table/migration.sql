-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Missao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "descricao" TEXT NOT NULL,
    "data_finalizacao" DATETIME NOT NULL,
    "situacao" TEXT NOT NULL DEFAULT 'ativa',
    "militar_origem" TEXT NOT NULL,
    "militar_destino" TEXT NOT NULL,
    CONSTRAINT "Missao_militar_destino_fkey" FOREIGN KEY ("militar_destino") REFERENCES "Militar" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Missao" ("created_at", "data_finalizacao", "descricao", "id", "militar_destino", "militar_origem", "situacao") SELECT "created_at", "data_finalizacao", "descricao", "id", "militar_destino", "militar_origem", "situacao" FROM "Missao";
DROP TABLE "Missao";
ALTER TABLE "new_Missao" RENAME TO "Missao";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
