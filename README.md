# ⚙️ SisAGIServer — Servidor do Sistema de Apoio à Gestão Interna

> API REST do SisAGI, responsável por toda a lógica de negócio, autenticação, acesso ao banco de dados e serviço de arquivos da aplicação.

---

## ⚠️ Status do Projeto

![Status](https://img.shields.io/badge/status-descontinuado-red)
![Contribuições](https://img.shields.io/badge/contribuições-bem--vindas-brightgreen)

**Este projeto está descontinuado.** O desenvolvimento foi iniciado em **2021** e encerrado após a submissão ao **PREMIA 2024**. O código está aberto para quem quiser retomá-lo, corrigir problemas ou implementar novas funcionalidades.

Por se tratar de um projeto de grande escopo desenvolvido durante as fases iniciais do autor como desenvolvedor, podem existir **falhas, bugs e pontos de melhoria**.

> 🏆 O SisAGI foi **submetido ao PREMIA 2024** (Prêmio do Exército Brasileiro de Inovação e Melhoria Administrativa).

---

## 📋 Sumário

- [Sobre](#sobre)
- [Tecnologias](#tecnologias)
- [Pré-requisitos](#pré-requisitos)
- [Instalação e Execução](#instalação-e-execução)
- [Variáveis de Ambiente](#variáveis-de-ambiente)
- [Banco de Dados](#banco-de-dados)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Contribuição](#contribuição)

---

## Sobre

Este repositório contém o **servidor (backend)** do SisAGI — Sistema de Apoio à Gestão Interna. Ele é uma API REST construída com **Fastify + TypeScript**, utilizando **Prisma ORM** para comunicação com o banco **PostgreSQL** e **JWT** para autenticação.

**Este não é um projeto oficial do Exército Brasileiro.** Trata-se de uma iniciativa individual de um militar desenvolvedor com o objetivo de modernizar a administração interna de uma Organização Militar (OM).

🔗 Repositório do frontend: [henrylsilveira/SisAGI](https://github.com/henrylsilveira/SisAGI)

---

## Tecnologias

| Categoria | Tecnologia |
|---|---|
| Runtime | [Node.js 20](https://nodejs.org/) |
| Linguagem | [TypeScript](https://www.typescriptlang.org/) |
| Framework HTTP | [Fastify](https://fastify.dev/) |
| ORM | [Prisma](https://www.prisma.io/) |
| Banco de Dados | [PostgreSQL](https://www.postgresql.org/) |
| Autenticação | [JWT via @fastify/jwt](https://github.com/fastify/fastify-jwt) |
| Validação | [Zod](https://zod.dev/) |
| Upload de Arquivos | [fastify-multer](https://github.com/fox1t/fastify-multer) |
| Arquivos Estáticos | [@fastify/static](https://github.com/fastify/fastify-static) |
| Criptografia | [bcrypt](https://github.com/kelektiv/node.bcrypt.js) |
| IDs Únicos | [short-unique-id](https://github.com/simplyhexagonal/short-unique-id) |
| Build | [tsup](https://tsup.egoist.dev/) |
| Dev (hot reload) | [tsx](https://github.com/privatenumber/tsx) |
| Container DB | [Docker Compose](https://docs.docker.com/compose/) |

---

## Pré-requisitos

- [Node.js](https://nodejs.org/) >= 20.x
- [Docker](https://www.docker.com/) e [Docker Compose](https://docs.docker.com/compose/) (para subir o banco de dados)
- [pnpm](https://pnpm.io/) (recomendado) ou npm

---

## Instalação e Execução

### 1. Clone o repositório

```bash
git clone https://github.com/henrylsilveira/SisAGIServer.git
cd SisAGIServer
```

### 2. Instale as dependências

```bash
pnpm install
# ou
npm install
```

### 3. Configure as variáveis de ambiente

Crie um arquivo `.env` na raiz do projeto (veja a seção [Variáveis de Ambiente](#variáveis-de-ambiente) abaixo).

### 4. Suba o banco de dados com Docker

```bash
docker compose up -d
```

Isso irá subir uma instância do **PostgreSQL** na porta `5432`.

### 5. Execute as migrations e setup inicial

```bash
# Aplica as migrations do Prisma e faz o seed inicial do projeto
npm run create
```

### 6. Inicie o servidor

```bash
# Desenvolvimento (com hot reload)
npm run dev

# Produção
npm run build
npm start
```

O servidor estará disponível em `http://localhost:3333` (ou a porta configurada no `.env`).

---

## Variáveis de Ambiente

Crie um arquivo `.env` na raiz com as seguintes variáveis:

```env
# Banco de dados (deve corresponder ao docker-compose.yml)
DATABASE_URL="postgresql://sisagi:SENHA@localhost:5432/sisagi"

# JWT
JWT_SECRET="sua_chave_secreta_jwt"

# Porta do servidor (opcional, padrão 3333)
PORT=3333
```

> ⚠️ A senha do banco configurada no `docker-compose.yml` é apenas para ambiente de desenvolvimento local. **Altere-a em produção.**

---

## Banco de Dados

O banco de dados é um **PostgreSQL** gerenciado via **Prisma ORM**. O schema e as migrations ficam na pasta `/prisma`.

### Comandos úteis do Prisma

```bash
# Gerar o Prisma Client após alterar o schema
npx prisma generate

# Criar uma nova migration
npx prisma migrate dev --name nome_da_migration

# Visualizar o banco no Prisma Studio
npx prisma studio
```

### Subindo o banco com Docker

O `docker-compose.yml` já configura o PostgreSQL com as credenciais padrão de desenvolvimento:

```yaml
POSTGRES_USER: sisagi
POSTGRES_DB:   sisagi
```

---

## Estrutura do Projeto

```
SisAGIServer/
├── prisma/
│   ├── schema.prisma        # Definição dos modelos do banco
│   └── migrations/          # Histórico de migrations
├── src/
│   ├── server.ts            # Ponto de entrada da aplicação
│   ├── routes/              # Definição das rotas da API
│   ├── controllers/         # Lógica de cada endpoint
│   ├── middlewares/         # Autenticação e outros middlewares
│   └── utils/               # Utilitários (ex: startProject.ts)
├── docker-compose.yml       # Configuração do PostgreSQL para dev
├── tsconfig.json
└── package.json
```

---

## Contribuição

O projeto está **aberto para qualquer pessoa que queira contribuir** — seja para corrigir bugs, atualizar dependências, refatorar o código ou implementar as funcionalidades ainda pendentes do SisAGI.

### Como contribuir

1. Faça um **fork** do projeto
2. Crie uma branch: `git checkout -b feature/minha-feature`
3. Commit suas mudanças: `git commit -m 'feat: minha contribuição'`
4. Push: `git push origin feature/minha-feature`
5. Abra um **Pull Request**

Dúvidas ou sugestões? Abra uma [issue](https://github.com/henrylsilveira/SisAGIServer/issues) ou entre em contato pelo GitHub.

---

## Aviso

Este é um projeto **pessoal e independente**, desenvolvido por um militar com perfil de desenvolvedor. **Não possui vínculo oficial com o Exército Brasileiro** nem com qualquer Organização Militar. O código é disponibilizado livremente para fins de estudo, melhoria e eventual uso por quem se interessar.

---

Desenvolvido por [henrylsilveira](https://github.com/henrylsilveira) - Portfolio: https://hleao.dev
