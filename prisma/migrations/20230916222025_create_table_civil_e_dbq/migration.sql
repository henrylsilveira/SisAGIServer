-- CreateTable
CREATE TABLE "Civil" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "foto" TEXT,
    "fotoDoc" TEXT,
    "nomeCompleto" TEXT NOT NULL,
    "identidade" TEXT,
    "cpf" TEXT,
    "nomePai" TEXT,
    "nomeMae" TEXT,
    "profissao" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- CreateTable
CREATE TABLE "Dbq" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "fotoDbq" TEXT,
    "fotoDocDbq" TEXT,
    "origem" TEXT,
    "destino" TEXT,
    "motivo" TEXT,
    "observacao" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "civilId" TEXT NOT NULL,
    CONSTRAINT "Dbq_civilId_fkey" FOREIGN KEY ("civilId") REFERENCES "Civil" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Civil_identidade_key" ON "Civil"("identidade");

-- CreateIndex
CREATE UNIQUE INDEX "Civil_cpf_key" ON "Civil"("cpf");
