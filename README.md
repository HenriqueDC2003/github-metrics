# GitHub Metrics Pipeline

Pipeline de observabilidade que coleta métricas dos repositórios do GitHub via API, armazena no PostgreSQL e visualiza no Grafana — tudo orquestrado com n8n e containerizado com Docker.

## Arquitetura

```
GitHub API
    │
    ▼
n8n (ETL)
 ├── Extração: HTTP Request autenticado
 ├── Transformação: filtragem e padronização em JavaScript
 └── Carga: UPSERT no PostgreSQL
    │
    ▼
PostgreSQL
    │
    ▼
Grafana (dashboards)
```

## Stack

| Ferramenta | Função |
|------------|--------|
| n8n | Orquestração do pipeline ETL |
| PostgreSQL 16 | Armazenamento das métricas |
| Grafana | Visualização |
| Docker Compose | Infraestrutura local |
| GitHub Actions | CI — valida e testa o ambiente a cada push |

## Como rodar localmente

**Pré-requisitos:** Docker e Docker Compose instalados.

```bash
# 1. Clone o repositório
git clone https://github.com/seu-usuario/github-metrics.git
cd github-metrics

# 2. Crie o .env e edite as senhas
make setup

# 3. Suba o ambiente
make up
```

**Acesso:**
- n8n: http://localhost:5678
- Grafana: http://localhost:3000

## Variáveis de ambiente

Copie `.env.example` para `.env` e preencha:

| Variável | Descrição |
|----------|-----------|
| `POSTGRES_PASSWORD` | Senha do banco |
| `N8N_PASSWORD` | Senha do n8n |
| `GRAFANA_PASSWORD` | Senha do Grafana |
| `GITHUB_TOKEN` | Personal Access Token do GitHub |
| `GITHUB_USERNAME` | Seu usuário do GitHub |

> ⚠️ O arquivo `.env` nunca sobe para o repositório (está no `.gitignore`).

## Pipeline n8n

O workflow roda diariamente e segue o fluxo:

1. **Schedule Trigger** — dispara a coleta
2. **Edit Fields** — injeta as credenciais do GitHub
3. **Code (montar request)** — prepara headers de autenticação
4. **HTTP Request** — bate na GitHub API (`/users/{username}/repos`)
5. **Code (transformar)** — filtra forks e padroniza os campos
6. **Execute SQL** — UPSERT na tabela `github_repos`

## Comandos úteis

```bash
make up       # Sobe o ambiente
make down     # Derruba o ambiente
make logs     # Acompanha os logs em tempo real
make ps       # Status dos containers
make reset    # Apaga tudo e recomeça do zero
```
