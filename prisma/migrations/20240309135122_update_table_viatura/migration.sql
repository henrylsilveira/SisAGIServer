/*
  Warnings:

  - A unique constraint covering the columns `[eb]` on the table `Viatura` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Viatura_eb_key" ON "Viatura"("eb");
