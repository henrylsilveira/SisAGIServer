-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Militar" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "identidade" TEXT NOT NULL,
    "post_grad" TEXT,
    "nome_completo" TEXT NOT NULL,
    "nome_guerra" TEXT NOT NULL,
    "avatar_url" TEXT,
    "senha" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "situacao_med" TEXT DEFAULT 'apto',
    "companhia" TEXT,
    "pelotao" TEXT,
    "fracao" TEXT,
    "funcao_fracao" TEXT,
    "funcao_local" TEXT NOT NULL DEFAULT 'comum',
    "local_cumpre_expediente" TEXT,
    "cpf" TEXT,
    "nome_pai" TEXT,
    "nome_mae" TEXT,
    "naturalidade" TEXT,
    "data_nascimento" DATETIME,
    "data_praca" DATETIME,
    "qmg_qmp" TEXT,
    "sexo" TEXT,
    "cidade" TEXT,
    "estado" TEXT,
    "bairro" TEXT,
    "nr_rua" TEXT,
    "complemento" TEXT,
    "cep" TEXT,
    "telefone" TEXT,
    "email" TEXT,
    "cargo_qcp" TEXT,
    "tipo_sanguineo" TEXT,
    "prec_cp" TEXT,
    "motocarro" TEXT DEFAULT 'não',
    "hab_militar" TEXT DEFAULT 'não',
    "indigena" TEXT DEFAULT 'não',
    "longitude" TEXT,
    "latitude" TEXT
);
INSERT INTO "new_Militar" ("avatar_url", "bairro", "cargo_qcp", "cep", "cidade", "companhia", "complemento", "cpf", "data_nascimento", "data_praca", "email", "estado", "fracao", "funcao_fracao", "funcao_local", "hab_militar", "id", "identidade", "indigena", "latitude", "local_cumpre_expediente", "longitude", "motocarro", "naturalidade", "nome_completo", "nome_guerra", "nome_mae", "nome_pai", "nr_rua", "pelotao", "post_grad", "prec_cp", "qmg_qmp", "senha", "sexo", "situacao_med", "status", "telefone", "tipo_sanguineo") SELECT "avatar_url", "bairro", "cargo_qcp", "cep", "cidade", "companhia", "complemento", "cpf", "data_nascimento", "data_praca", "email", "estado", "fracao", "funcao_fracao", "funcao_local", "hab_militar", "id", "identidade", "indigena", "latitude", "local_cumpre_expediente", "longitude", "motocarro", "naturalidade", "nome_completo", "nome_guerra", "nome_mae", "nome_pai", "nr_rua", "pelotao", "post_grad", "prec_cp", "qmg_qmp", "senha", "sexo", "situacao_med", "status", "telefone", "tipo_sanguineo" FROM "Militar";
DROP TABLE "Militar";
ALTER TABLE "new_Militar" RENAME TO "Militar";
CREATE UNIQUE INDEX "Militar_identidade_key" ON "Militar"("identidade");
CREATE UNIQUE INDEX "Militar_cpf_key" ON "Militar"("cpf");
CREATE TABLE "new_Missao" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "descricao" TEXT NOT NULL,
    "data_finalizacao" DATETIME NOT NULL,
    "situacao" TEXT NOT NULL DEFAULT 'ativa',
    "militar_origem" TEXT NOT NULL,
    "militar_destino" TEXT NOT NULL,
    CONSTRAINT "Missao_militar_origem_fkey" FOREIGN KEY ("militar_origem") REFERENCES "Militar" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Missao" ("created_at", "data_finalizacao", "descricao", "id", "militar_destino", "militar_origem", "situacao") SELECT "created_at", "data_finalizacao", "descricao", "id", "militar_destino", "militar_origem", "situacao" FROM "Missao";
DROP TABLE "Missao";
ALTER TABLE "new_Missao" RENAME TO "Missao";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
