-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Cautela" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "data_cautela" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observacao" TEXT NOT NULL,
    "local" TEXT NOT NULL,
    "validado" BOOLEAN NOT NULL,
    "resp_cautela" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "cautelouId" TEXT NOT NULL,
    "materialId" TEXT NOT NULL,
    CONSTRAINT "Cautela_cautelouId_fkey" FOREIGN KEY ("cautelouId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Cautela_materialId_fkey" FOREIGN KEY ("materialId") REFERENCES "Material" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Cautela" ("cautelouId", "data_cautela", "id", "local", "materialId", "observacao", "resp_cautela", "validado") SELECT "cautelouId", "data_cautela", "id", "local", "materialId", "observacao", "resp_cautela", "validado" FROM "Cautela";
DROP TABLE "Cautela";
ALTER TABLE "new_Cautela" RENAME TO "Cautela";
CREATE TABLE "new_Militar" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "identidade" TEXT NOT NULL,
    "nome_completo" TEXT NOT NULL,
    "nome_guerra" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "permissao" TEXT,
    "local" TEXT,
    "funcao_local" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo'
);
INSERT INTO "new_Militar" ("funcao_local", "id", "identidade", "nome_completo", "nome_guerra", "permissao", "senha") SELECT "funcao_local", "id", "identidade", "nome_completo", "nome_guerra", "permissao", "senha" FROM "Militar";
DROP TABLE "Militar";
ALTER TABLE "new_Militar" RENAME TO "Militar";
CREATE UNIQUE INDEX "Militar_identidade_key" ON "Militar"("identidade");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
