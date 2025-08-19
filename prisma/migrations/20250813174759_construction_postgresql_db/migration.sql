-- CreateTable
CREATE TABLE "Militar" (
    "id" TEXT NOT NULL,
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
    "data_nascimento" TIMESTAMP(3),
    "data_praca" TIMESTAMP(3),
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
    "latitude" TEXT,

    CONSTRAINT "Militar_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Civil" (
    "id" TEXT NOT NULL,
    "foto" TEXT,
    "fotoDoc" TEXT,
    "nomeCompleto" TEXT NOT NULL,
    "categoria" TEXT NOT NULL,
    "identidade" TEXT,
    "cpf" TEXT,
    "nomePai" TEXT,
    "nomeMae" TEXT,
    "profissao" TEXT,
    "dataNascimento" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Civil_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Material" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "condicoes" TEXT,
    "quantidade" INTEGER,
    "codigo" TEXT,
    "sub_unidade" TEXT,
    "dependencia" TEXT,
    "categoria" TEXT,

    CONSTRAINT "Material_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cautela" (
    "id" TEXT NOT NULL,
    "data_cautela" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observacao" TEXT NOT NULL,
    "sub_unidade" TEXT NOT NULL,
    "dependencia" TEXT NOT NULL,
    "quantidade" INTEGER DEFAULT 1,
    "validado" BOOLEAN NOT NULL,
    "resp_cautela" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "data_fechamento_cautela" TIMESTAMP(3),
    "cautelouId" TEXT NOT NULL,
    "materialId" TEXT NOT NULL,

    CONSTRAINT "Cautela_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CautelaArmamento" (
    "id" TEXT NOT NULL,
    "data_cautela" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observacao" TEXT,
    "companhia" TEXT NOT NULL,
    "quantidade" INTEGER DEFAULT 1,
    "validado" BOOLEAN NOT NULL,
    "resp_cautela" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "data_fechamento_cautela" TIMESTAMP(3),
    "cautelouId" TEXT NOT NULL,
    "armamentoId" TEXT NOT NULL,

    CONSTRAINT "CautelaArmamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Armamento" (
    "id" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "nr_serie" TEXT NOT NULL,
    "tipo" TEXT,
    "emprego" TEXT,
    "condicoes" TEXT,
    "companhia" TEXT,
    "dependencia" TEXT,
    "cabide" TEXT,
    "statusCautela" TEXT NOT NULL DEFAULT 'disponivel',
    "status" TEXT NOT NULL DEFAULT 'disponivel',

    CONSTRAINT "Armamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Municao" (
    "id" TEXT NOT NULL,
    "nr_pedido" TEXT NOT NULL,
    "municao_pedida" INTEGER NOT NULL,
    "municao_usada" INTEGER,
    "municao_devolvida" INTEGER,
    "unidade" TEXT NOT NULL,
    "tipo_municao" TEXT NOT NULL,
    "data_instrucao" TIMESTAMP(3),
    "data_devolucao" TIMESTAMP(3),
    "instrucao" TEXT,
    "companhia" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "militarId" TEXT NOT NULL,

    CONSTRAINT "Municao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Combustivel" (
    "id" TEXT NOT NULL,
    "nr_pedido" TEXT NOT NULL,
    "combustivel_pedido" INTEGER NOT NULL,
    "combustivel_usado" INTEGER NOT NULL,
    "combustivel_devolvido" INTEGER NOT NULL,
    "unidade" TEXT NOT NULL,
    "companhia" TEXT NOT NULL,
    "tipo_combustivel" TEXT NOT NULL,
    "data_missao" TIMESTAMP(3),
    "data_devolucao" TIMESTAMP(3),
    "missao" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "militarId" TEXT NOT NULL,

    CONSTRAINT "Combustivel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Manutencao" (
    "id" TEXT NOT NULL,
    "tipoManutencao" TEXT NOT NULL,
    "dataManutencao" TIMESTAMP(3) NOT NULL,
    "armamentoId" TEXT NOT NULL,

    CONSTRAINT "Manutencao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ArmamentoMilitar" (
    "id" TEXT NOT NULL,
    "armamentoId" TEXT NOT NULL,
    "militarId" TEXT NOT NULL,

    CONSTRAINT "ArmamentoMilitar_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Funcao" (
    "id" TEXT NOT NULL,
    "funcao" TEXT NOT NULL,
    "data_inicio" TIMESTAMP(3) NOT NULL,
    "data_termino" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" TEXT NOT NULL DEFAULT 'ativo',
    "militarId" TEXT NOT NULL,

    CONSTRAINT "Funcao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Session" (
    "id" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "militarId" TEXT NOT NULL,
    "access" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expires" TIMESTAMP(3) NOT NULL,
    "ipAccess" TEXT,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Feedback" (
    "id" TEXT NOT NULL,
    "dateFeedback" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imageFeedback_url" TEXT,
    "informacao" TEXT NOT NULL,
    "militarId" TEXT NOT NULL,

    CONSTRAINT "Feedback_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Missao" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "descricao" TEXT NOT NULL,
    "data_finalizacao" TIMESTAMP(3) NOT NULL,
    "situacao" TEXT NOT NULL DEFAULT 'ativa',
    "militar_origem" TEXT NOT NULL,
    "militar_destino" TEXT NOT NULL,

    CONSTRAINT "Missao_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ControleGuarda" (
    "id" TEXT NOT NULL,
    "entrada" TIMESTAMP(3),
    "saida" TIMESTAMP(3),
    "destino" TEXT,
    "status" TEXT DEFAULT 'ativo',
    "militarServicoId" TEXT NOT NULL,
    "militarId" TEXT,
    "civilId" TEXT,

    CONSTRAINT "ControleGuarda_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Dbq" (
    "id" TEXT NOT NULL,
    "fotoDbq" TEXT,
    "fotoDocDbq" TEXT,
    "origem" TEXT,
    "destino" TEXT,
    "motivo" TEXT,
    "observacao" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "civilId" TEXT NOT NULL,
    "militarId" TEXT NOT NULL,

    CONSTRAINT "Dbq_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Viatura" (
    "id" TEXT NOT NULL,
    "eb" TEXT NOT NULL,
    "tipo" TEXT NOT NULL,
    "tipoTransporte" TEXT NOT NULL,
    "situacao" TEXT NOT NULL DEFAULT 'disponivel',

    CONSTRAINT "Viatura_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ManutencaoViatura" (
    "id" TEXT NOT NULL,
    "data" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "motivo" TEXT NOT NULL,
    "viaturaId" TEXT NOT NULL,

    CONSTRAINT "ManutencaoViatura_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PedidoViatura" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dataDesejada" TIMESTAMP(3) NOT NULL,
    "missao" TEXT NOT NULL,
    "intinerario" TEXT NOT NULL,
    "chefeViatura" TEXT NOT NULL,
    "motorista" TEXT,
    "dataDevolucao" TIMESTAMP(3) NOT NULL,
    "apresentar" TEXT NOT NULL,
    "observacao" TEXT NOT NULL DEFAULT '',
    "status" TEXT NOT NULL DEFAULT 'aguardando',
    "companhia" TEXT NOT NULL DEFAULT '',
    "autorizado" BOOLEAN NOT NULL DEFAULT false,
    "militarIdPedido" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "PedidoViatura_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CautelaViatura" (
    "id" TEXT NOT NULL,
    "dataCautela" TIMESTAMP(3) NOT NULL,
    "dataEntrega" TIMESTAMP(3) NOT NULL,
    "motorista" TEXT NOT NULL,
    "observacao" TEXT NOT NULL DEFAULT '',
    "status" TEXT NOT NULL DEFAULT 'pendente',
    "viaturaId" TEXT NOT NULL,
    "pedidoViaturaId" TEXT NOT NULL,

    CONSTRAINT "CautelaViatura_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Militar_identidade_key" ON "Militar"("identidade");

-- CreateIndex
CREATE UNIQUE INDEX "Militar_cpf_key" ON "Militar"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "Civil_identidade_key" ON "Civil"("identidade");

-- CreateIndex
CREATE UNIQUE INDEX "Civil_cpf_key" ON "Civil"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "Funcao_funcao_militarId_key" ON "Funcao"("funcao", "militarId");

-- CreateIndex
CREATE UNIQUE INDEX "Session_sessionToken_key" ON "Session"("sessionToken");

-- CreateIndex
CREATE UNIQUE INDEX "Viatura_eb_key" ON "Viatura"("eb");

-- AddForeignKey
ALTER TABLE "Cautela" ADD CONSTRAINT "Cautela_cautelouId_fkey" FOREIGN KEY ("cautelouId") REFERENCES "Militar"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cautela" ADD CONSTRAINT "Cautela_materialId_fkey" FOREIGN KEY ("materialId") REFERENCES "Material"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CautelaArmamento" ADD CONSTRAINT "CautelaArmamento_cautelouId_fkey" FOREIGN KEY ("cautelouId") REFERENCES "Militar"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CautelaArmamento" ADD CONSTRAINT "CautelaArmamento_armamentoId_fkey" FOREIGN KEY ("armamentoId") REFERENCES "Armamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Municao" ADD CONSTRAINT "Municao_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Combustivel" ADD CONSTRAINT "Combustivel_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Manutencao" ADD CONSTRAINT "Manutencao_armamentoId_fkey" FOREIGN KEY ("armamentoId") REFERENCES "Armamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ArmamentoMilitar" ADD CONSTRAINT "ArmamentoMilitar_armamentoId_fkey" FOREIGN KEY ("armamentoId") REFERENCES "Armamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ArmamentoMilitar" ADD CONSTRAINT "ArmamentoMilitar_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Funcao" ADD CONSTRAINT "Funcao_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Feedback" ADD CONSTRAINT "Feedback_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Missao" ADD CONSTRAINT "Missao_militar_destino_fkey" FOREIGN KEY ("militar_destino") REFERENCES "Militar"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ControleGuarda" ADD CONSTRAINT "ControleGuarda_militarServicoId_fkey" FOREIGN KEY ("militarServicoId") REFERENCES "Militar"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ControleGuarda" ADD CONSTRAINT "ControleGuarda_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ControleGuarda" ADD CONSTRAINT "ControleGuarda_civilId_fkey" FOREIGN KEY ("civilId") REFERENCES "Civil"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dbq" ADD CONSTRAINT "Dbq_civilId_fkey" FOREIGN KEY ("civilId") REFERENCES "Civil"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Dbq" ADD CONSTRAINT "Dbq_militarId_fkey" FOREIGN KEY ("militarId") REFERENCES "Militar"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ManutencaoViatura" ADD CONSTRAINT "ManutencaoViatura_viaturaId_fkey" FOREIGN KEY ("viaturaId") REFERENCES "Viatura"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PedidoViatura" ADD CONSTRAINT "PedidoViatura_militarIdPedido_fkey" FOREIGN KEY ("militarIdPedido") REFERENCES "Militar"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CautelaViatura" ADD CONSTRAINT "CautelaViatura_viaturaId_fkey" FOREIGN KEY ("viaturaId") REFERENCES "Viatura"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CautelaViatura" ADD CONSTRAINT "CautelaViatura_pedidoViaturaId_fkey" FOREIGN KEY ("pedidoViaturaId") REFERENCES "PedidoViatura"("id") ON DELETE CASCADE ON UPDATE CASCADE;
