/*
  Warnings:

  - A unique constraint covering the columns `[cpf]` on the table `Militar` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "Militar" ADD COLUMN "bairro" TEXT;
ALTER TABLE "Militar" ADD COLUMN "cargo_qcp" TEXT;
ALTER TABLE "Militar" ADD COLUMN "cep" TEXT;
ALTER TABLE "Militar" ADD COLUMN "cidade" TEXT;
ALTER TABLE "Militar" ADD COLUMN "complemento" TEXT;
ALTER TABLE "Militar" ADD COLUMN "cpf" TEXT;
ALTER TABLE "Militar" ADD COLUMN "data_nascimento" DATETIME;
ALTER TABLE "Militar" ADD COLUMN "data_praca" DATETIME;
ALTER TABLE "Militar" ADD COLUMN "email" TEXT;
ALTER TABLE "Militar" ADD COLUMN "estado" TEXT;
ALTER TABLE "Militar" ADD COLUMN "hab_militar" TEXT;
ALTER TABLE "Militar" ADD COLUMN "local_cumpre_expediente" TEXT;
ALTER TABLE "Militar" ADD COLUMN "motocarro" TEXT;
ALTER TABLE "Militar" ADD COLUMN "naturalidade" TEXT;
ALTER TABLE "Militar" ADD COLUMN "nome_mae" TEXT;
ALTER TABLE "Militar" ADD COLUMN "nome_pai" TEXT;
ALTER TABLE "Militar" ADD COLUMN "nr_rua" TEXT;
ALTER TABLE "Militar" ADD COLUMN "prec_cp" TEXT;
ALTER TABLE "Militar" ADD COLUMN "qmg_qmp" TEXT;
ALTER TABLE "Militar" ADD COLUMN "sexo" TEXT;
ALTER TABLE "Militar" ADD COLUMN "telefone" TEXT;
ALTER TABLE "Militar" ADD COLUMN "tipo_sanguineo" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "Militar_cpf_key" ON "Militar"("cpf");
