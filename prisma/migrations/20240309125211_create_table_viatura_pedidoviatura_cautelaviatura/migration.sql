-- CreateTable
CREATE TABLE "Viatura" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "eb" TEXT NOT NULL,
    "tipo" TEXT NOT NULL,
    "tipoTransporte" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "PedidoViatura" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dataDesejada" DATETIME NOT NULL,
    "missao" TEXT NOT NULL,
    "intinerario" TEXT NOT NULL,
    "chefeViatura" TEXT NOT NULL,
    "motorista" TEXT,
    "dataDevolucao" DATETIME NOT NULL,
    "apresentar" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "CautelaViatura" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "dataCautela" DATETIME NOT NULL,
    "dataEntrega" DATETIME NOT NULL,
    "motorista" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'pendente',
    "viaturaId" TEXT NOT NULL,
    "pedidoViaturaId" TEXT NOT NULL,
    CONSTRAINT "CautelaViatura_viaturaId_fkey" FOREIGN KEY ("viaturaId") REFERENCES "Viatura" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "CautelaViatura_pedidoViaturaId_fkey" FOREIGN KEY ("pedidoViaturaId") REFERENCES "PedidoViatura" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
