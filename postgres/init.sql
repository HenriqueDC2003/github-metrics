CREATE TABLE IF NOT EXISTS github_repos (
    repo_name       TEXT        NOT NULL,
    linguagem       TEXT,
    estrelas        INTEGER     DEFAULT 0,
    forks           INTEGER     DEFAULT 0,
    issues_abertas  INTEGER     DEFAULT 0,
    tamanho_kb      INTEGER     DEFAULT 0,
    ultimo_push     TIMESTAMP,
    data_coleta     DATE        NOT NULL,
    PRIMARY KEY (repo_name, data_coleta)
);

COMMENT ON TABLE github_repos IS 'Snapshot diário dos repositórios do GitHub';
COMMENT ON COLUMN github_repos.repo_name IS 'Nome do repositório';
COMMENT ON COLUMN github_repos.data_coleta IS 'Data em que os dados foram coletados';
