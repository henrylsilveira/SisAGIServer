/*
  Warnings:

  - A unique constraint covering the columns `[funcao,militarId]` on the table `Funcao` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Funcao_funcao_militarId_key" ON "Funcao"("funcao", "militarId");
