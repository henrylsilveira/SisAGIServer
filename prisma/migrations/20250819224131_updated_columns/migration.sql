/*
  Warnings:

  - The `entrada` column on the `ControleGuarda` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `saida` column on the `ControleGuarda` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- AlterTable
ALTER TABLE "ControleGuarda" DROP COLUMN "entrada",
ADD COLUMN     "entrada" TIMESTAMPTZ(3),
DROP COLUMN "saida",
ADD COLUMN     "saida" TIMESTAMPTZ(3);
