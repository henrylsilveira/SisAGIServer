-- CreateTable
CREATE TABLE "ManutencaoViatura" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "data" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "motivo" TEXT NOT NULL,
    "viaturaId" TEXT NOT NULL,
    CONSTRAINT "ManutencaoViatura_viaturaId_fkey" FOREIGN KEY ("viaturaId") REFERENCES "Viatura" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
