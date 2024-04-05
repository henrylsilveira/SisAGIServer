-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_ControleGuarda" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "entrada" DATETIME,
    "saida" DATETIME,
    "destino" TEXT,
    "status" TEXT DEFAULT 'ativo',
    "militarServicoId" TEXT NOT NULL,
    "pessoaId" TEXT NOT NULL,
    CONSTRAINT "ControleGuarda_militarServicoId_fkey" FOREIGN KEY ("militarServicoId") REFERENCES "Militar" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "ControleGuarda_pessoaId_fkey" FOREIGN KEY ("pessoaId") REFERENCES "Militar" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "ControleGuarda_pessoaId_fkey" FOREIGN KEY ("pessoaId") REFERENCES "Civil" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_ControleGuarda" ("destino", "entrada", "id", "militarServicoId", "pessoaId", "saida", "status") SELECT "destino", "entrada", "id", "militarServicoId", "pessoaId", "saida", "status" FROM "ControleGuarda";
DROP TABLE "ControleGuarda";
ALTER TABLE "new_ControleGuarda" RENAME TO "ControleGuarda";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
