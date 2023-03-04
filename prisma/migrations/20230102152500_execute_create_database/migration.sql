-- CreateTable
CREATE TABLE "Militar" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "identidade" TEXT NOT NULL,
    "nome_completo" TEXT NOT NULL,
    "nome_guerra" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "permissao" TEXT NOT NULL,
    "funcao_local" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Material" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "condicoes" TEXT NOT NULL,
    "quantidade" INTEGER NOT NULL,
    "local" TEXT NOT NULL,
    "codigo" TEXT,
    "sub_unidade" TEXT,
    "dependencia" TEXT,
    "categoria" TEXT
);

-- CreateTable
CREATE TABLE "Cautela" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "data_cautela" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observacao" TEXT NOT NULL,
    "local" TEXT NOT NULL,
    "validado" BOOLEAN NOT NULL,
    "resp_cautela" TEXT NOT NULL,
    "cautelouId" TEXT NOT NULL,
    "materialId" TEXT NOT NULL,
    CONSTRAINT "Cautela_cautelouId_fkey" FOREIGN KEY ("cautelouId") REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Cautela_materialId_fkey" FOREIGN KEY ("materialId") REFERENCES "Material" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Militar_identidade_key" ON "Militar"("identidade");

-- CreateIndex
CREATE UNIQUE INDEX "Material_nome_key" ON "Material"("nome");
