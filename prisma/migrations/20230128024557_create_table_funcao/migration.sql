-- CreateTable
CREATE TABLE "Funcao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "funcao" TEXT NOT NULL,
    "data_inicio" DATETIME NOT NULL,
    "data_termino" DATETIME NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "militarId" TEXT NOT NULL,
    CONSTRAINT "Funcao_militarId_fkey" 
    FOREIGN KEY ("militarId") 
    REFERENCES "Militar" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
