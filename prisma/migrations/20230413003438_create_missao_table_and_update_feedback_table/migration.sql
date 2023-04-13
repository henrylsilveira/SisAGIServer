-- AlterTable
ALTER TABLE "Feedback" ADD COLUMN "imageFeedback_url" TEXT;

-- AlterTable
ALTER TABLE "Militar" ADD COLUMN "indigena" TEXT DEFAULT 'não';
ALTER TABLE "Militar" ADD COLUMN "situacao_med" TEXT DEFAULT 'apto';

-- CreateTable
CREATE TABLE "Missao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "descricao" TEXT NOT NULL,
    "data_finalizacao" DATETIME NOT NULL,
    "situacao" TEXT NOT NULL DEFAULT 'ativa',
    "militar_origem" TEXT NOT NULL,
    "militar_destino" TEXT NOT NULL,
    CONSTRAINT "Missao_militar_origem_fkey" FOREIGN KEY ("militar_origem") REFERENCES "Militar" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
