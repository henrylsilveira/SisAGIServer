<div align="center">

# ⚙️ SisAGIServer — Servidor do Sistema de Apoio à Gestão Interna

[![Português](https://img.shields.io/badge/lang-PT--BR-009c3b?style=for-the-badge)](https://github.com/henrylsilveira/SisAGIServer#-versão-em-português)
[![English](https://img.shields.io/badge/lang-EN-002776?style=for-the-badge)](https://github.com/henrylsilveira/SisAGIServer#-english-version)

</div>

---
# 🇺🇸 English Version

> REST API for SisAGI, responsible for all business logic, authentication, database access, and file serving.

## ⚠️ Project Status

![Status](https://img.shields.io/badge/status-discontinued-red)
![Contributions](https://img.shields.io/badge/contributions-welcome-brightgreen)

**This project is discontinued.** Development started in **2021** and was halted after the submission to **PREMIA 2024**. The code is open for anyone who wants to pick it up, fix issues, or implement new features.

Since this is a large-scope project built during the author's early stages as a developer, there may be **bugs, flaws, and room for improvement** — any contribution is very welcome!

> 🏆 SisAGI was **submitted to PREMIA 2024** (Brazilian Army Innovation and Administrative Improvement Award).

## 📋 Table of Contents

- [About](#about)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Environment Variables](#environment-variables)
- [Database](#database)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [About the Author](#about-the-author)

## About

This repository contains the **backend server** for SisAGI — Internal Management Support System. It is a REST API built with **Fastify + TypeScript**, using **Prisma ORM** to communicate with a **PostgreSQL** database and **JWT** for authentication.

**This is not an official Brazilian Army project.** It is an individual initiative by a soldier-developer aimed at modernizing the internal administration of a Military Organization (MO).

🔗 Frontend repository: [henrylsilveira/SisAGI](https://github.com/henrylsilveira/SisAGI)

## 🛠️ Tech Stack

| Category | Technology |
|---|---|
| Runtime | [Node.js 20](https://nodejs.org/) |
| Language | [TypeScript](https://www.typescriptlang.org/) |
| HTTP Framework | [Fastify](https://fastify.dev/) |
| ORM | [Prisma](https://www.prisma.io/) |
| Database | [PostgreSQL](https://www.postgresql.org/) |
| Authentication | [JWT via @fastify/jwt](https://github.com/fastify/fastify-jwt) |
| Validation | [Zod](https://zod.dev/) |
| File Upload | [fastify-multer](https://github.com/fox1t/fastify-multer) |
| Static Files | [@fastify/static](https://github.com/fastify/fastify-static) |
| Cryptography | [bcrypt](https://github.com/kelektiv/node.bcrypt.js) |
| Unique IDs | [short-unique-id](https://github.com/simplyhexagonal/short-unique-id) |
| Build | [tsup](https://tsup.egoist.dev/) |
| Dev (hot reload) | [tsx](https://github.com/privatenumber/tsx) |
| DB Container | [Docker Compose](https://docs.docker.com/compose/) |

## 📦 Prerequisites

- [Node.js](https://nodejs.org/) >= 20.x
- [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)
- [pnpm](https://pnpm.io/) (recommended) or npm

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/henrylsilveira/SisAGIServer.git
cd SisAGIServer
```

### 2. Install dependencies

```bash
pnpm install
# or
npm install
```

### 3. Set up environment variables

Create a `.env` file at the project root (see below).

### 4. Start the database with Docker

```bash
docker compose up -d
```

### 5. Run migrations and initial setup

```bash
npm run create
```

### 6. Start the server

```bash
# Development (hot reload)
npm run dev

# Production
npm run build
npm start
```

The server will be available at `http://localhost:3333`.

## 🔑 Environment Variables

Create a `.env` file at the project root with:

```env
# Database
DATABASE_URL="postgresql://sisagi:PASSWORD@localhost:5432/sisagi"

# JWT
JWT_SECRET="your_jwt_secret_key"

# Port (optional, defaults to 3333)
PORT=3333
```

> ⚠️ The database password in `docker-compose.yml` is for local development only. **Change it before deploying to production.**

## 🗄️ Database

The database is **PostgreSQL** managed via **Prisma ORM**. The schema and migrations are located in the `/prisma` folder.

### Useful commands

```bash
# Regenerate Prisma Client after schema changes
npx prisma generate

# Create a new migration
npx prisma migrate dev --name migration_name

# Open Prisma Studio (visual DB browser)
npx prisma studio
```

## 📁 Project Structure

```
SisAGIServer/
├── prisma/
│   ├── schema.prisma        # Database model definitions
│   └── migrations/          # Migration history
├── src/
│   ├── server.ts            # Application entry point
│   ├── routes/              # API route definitions
│   ├── controllers/         # Endpoint logic
│   ├── middlewares/         # Auth and other middlewares
│   └── utils/               # Utility functions
├── docker-compose.yml       # PostgreSQL for development
├── tsconfig.json
└── package.json
```

## 🤝 Contributing

This project is **open to anyone who wants to contribute** — whether to fix bugs, update dependencies, refactor the code, or implement pending features.

If you are a soldier, a developer, or both — your help is especially welcome!

1. **Fork** the repository
2. Create your branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m 'feat: my contribution'`
4. Push: `git push origin feature/my-feature`
5. Open a **Pull Request**

Questions? Open an [issue](https://github.com/henrylsilveira/SisAGIServer/issues).

## 👨‍💻 About the Author

**Henry Leão** is a Brazilian Army soldier who taught himself software development to solve real problems he faced in his daily military duties. Over time, his side projects grew from internal tools into public platforms used by soldiers across Brazil.

His work sits at the intersection of **software engineering** and **military operations** — building tools that modernize administrative processes and improve the day-to-day lives of military personnel. Beyond web development, he also studies **offensive security and Red Team** techniques.

**Stack:** TypeScript · JavaScript · React · Next.js · Node.js · Prisma · PostgreSQL · React Native · Tailwind CSS

**Other projects:**
- 🪖 [SisAGI Frontend](https://github.com/henrylsilveira/SisAGI) — Web interface for the system, submitted to **PREMIA 2024**
- 🧮 [ebcalc.net](https://ebcalc.net) — Military pay calculator platform for Brazilian Army soldiers

[![Portfolio](https://img.shields.io/badge/Portfolio-000?style=for-the-badge&logo=vercel&logoColor=white)](https://hleao.dev)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/henryleao)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/henrylsilveira)
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:henrylsilveira@gmail.com)

## ⚖️ Disclaimer

This is a **personal and independent project**, developed by a soldier with a developer mindset. It has **no official affiliation with the Brazilian Army** or any Military Organization. The code is freely available for study, improvement, and eventual use by anyone interested.

---

Built with 🖥️ + 🪖 by [henrylsilveira](https://github.com/henrylsilveira)


# 🇧🇷 Versão em Português

> API REST do SisAGI, responsável por toda a lógica de negócio, autenticação, acesso ao banco de dados e serviço de arquivos da aplicação.

## ⚠️ Status do Projeto

![Status](https://img.shields.io/badge/status-descontinuado-red)
![Contribuições](https://img.shields.io/badge/contribuições-bem--vindas-brightgreen)

**Este projeto está descontinuado.** O desenvolvimento foi iniciado em **2021** e encerrado após a submissão ao **PREMIA 2024**. O código está aberto para quem quiser retomá-lo, corrigir problemas ou implementar novas funcionalidades.

Por se tratar de um projeto de grande escopo desenvolvido durante as fases iniciais do autor como desenvolvedor, podem existir **falhas, bugs e pontos de melhoria** — qualquer contribuição é muito bem-vinda!

> 🏆 O SisAGI foi **submetido ao PREMIA 2024** (Prêmio do Exército Brasileiro de Inovação e Melhoria Administrativa).

## 📋 Sumário

- [Sobre](#sobre)
- [Tecnologias](#tecnologias)
- [Pré-requisitos](#pré-requisitos)
- [Instalação e Execução](#instalação-e-execução)
- [Variáveis de Ambiente](#variáveis-de-ambiente)
- [Banco de Dados](#banco-de-dados)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Contribuição](#contribuição)
- [Sobre o Autor](#sobre-o-autor)

## Sobre

Este repositório contém o **servidor (backend)** do SisAGI — Sistema de Apoio à Gestão Interna. É uma API REST construída com **Fastify + TypeScript**, utilizando **Prisma ORM** para comunicação com o banco **PostgreSQL** e **JWT** para autenticação.

**Este não é um projeto oficial do Exército Brasileiro.** Trata-se de uma iniciativa individual de um militar desenvolvedor com o objetivo de modernizar a administração interna de uma Organização Militar (OM).

🔗 Repositório do frontend: [henrylsilveira/SisAGI](https://github.com/henrylsilveira/SisAGI)

## 🛠️ Tecnologias

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

## 📦 Pré-requisitos

- [Node.js](https://nodejs.org/) >= 20.x
- [Docker](https://www.docker.com/) e [Docker Compose](https://docs.docker.com/compose/)
- [pnpm](https://pnpm.io/) (recomendado) ou npm

## 🚀 Instalação e Execução

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

Crie um arquivo `.env` na raiz do projeto (veja a seção abaixo).

### 4. Suba o banco de dados com Docker

```bash
docker compose up -d
```

### 5. Execute as migrations e setup inicial

```bash
npm run create
```

### 6. Inicie o servidor

```bash
# Desenvolvimento (hot reload)
npm run dev

# Produção
npm run build
npm start
```

O servidor estará disponível em `http://localhost:3333`.

## 🔑 Variáveis de Ambiente

Crie um arquivo `.env` na raiz com:

```env
# Banco de dados
DATABASE_URL="postgresql://sisagi:SENHA@localhost:5432/sisagi"

# JWT
JWT_SECRET="sua_chave_secreta_jwt"

# Porta (opcional, padrão 3333)
PORT=3333
```

> ⚠️ A senha do banco no `docker-compose.yml` é apenas para desenvolvimento local. **Altere-a em produção.**

## 🗄️ Banco de Dados

O banco de dados é um **PostgreSQL** gerenciado via **Prisma ORM**. O schema e as migrations ficam na pasta `/prisma`.

### Comandos úteis

```bash
# Gerar o Prisma Client após alterar o schema
npx prisma generate

# Criar uma nova migration
npx prisma migrate dev --name nome_da_migration

# Visualizar o banco no Prisma Studio
npx prisma studio
```

## 📁 Estrutura do Projeto

```
SisAGIServer/
├── prisma/
│   ├── schema.prisma        # Definição dos modelos do banco
│   └── migrations/          # Histórico de migrations
├── src/
│   ├── server.ts            # Ponto de entrada da aplicação
│   ├── routes/              # Rotas da API
│   ├── controllers/         # Lógica de cada endpoint
│   ├── middlewares/         # Autenticação e outros middlewares
│   └── utils/               # Utilitários
├── docker-compose.yml       # PostgreSQL para desenvolvimento
├── tsconfig.json
└── package.json
```

## 🤝 Contribuição

O projeto está **aberto para qualquer pessoa que queira contribuir** — seja para corrigir bugs, atualizar dependências, refatorar o código ou implementar funcionalidades pendentes.

Se você é militar, desenvolvedor, ou os dois — sua ajuda é especialmente bem-vinda!

1. Faça um **fork** do projeto
2. Crie uma branch: `git checkout -b feature/minha-feature`
3. Commit: `git commit -m 'feat: minha contribuição'`
4. Push: `git push origin feature/minha-feature`
5. Abra um **Pull Request**

Dúvidas? Abra uma [issue](https://github.com/henrylsilveira/SisAGIServer/issues).

## 👨‍💻 Sobre o Autor

**Henry Leão** é um militar do Exército Brasileiro que aprendeu desenvolvimento de software para resolver problemas reais do serviço. Com o tempo, seus projetos pessoais cresceram de ferramentas internas para plataformas públicas utilizadas por militares em todo o Brasil.

Seu trabalho está na interseção entre **engenharia de software** e **operações militares** — construindo ferramentas que modernizam processos administrativos e facilitam o dia a dia do serviço militar. Além do desenvolvimento web, também estuda **segurança ofensiva e Red Team**.

**Stack:** TypeScript · JavaScript · React · Next.js · Node.js · Prisma · PostgreSQL · React Native · Tailwind CSS

**Outros projetos:**
- 🪖 [SisAGI Frontend](https://github.com/henrylsilveira/SisAGI) — Interface web do sistema, submetida ao **PREMIA 2024**
- 🧮 [ebcalc.net](https://ebcalc.net) — Plataforma de cálculo de proventos para militares do EB

[![Portfólio](https://img.shields.io/badge/Portfólio-000?style=for-the-badge&logo=vercel&logoColor=white)](https://hleao.dev)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/henryleao)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/henrylsilveira)
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:henrylsilveira@gmail.com)

## ⚖️ Aviso

Este é um projeto **pessoal e independente**, desenvolvido por um militar com perfil de desenvolvedor. **Não possui vínculo oficial com o Exército Brasileiro** nem com qualquer Organização Militar. O código é disponibilizado livremente para fins de estudo, melhoria e eventual uso por quem se interessar.

---
---
