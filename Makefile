.PHONY: up down logs reset ps setup

setup:
	cp .env.example .env
	@echo "✅ .env criado. Edite as senhas antes de subir."

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f

ps:
	docker compose ps

reset:
	docker compose down -v
	docker compose up -d
	@echo "⚠️  Todos os volumes foram apagados e o ambiente foi reiniciado do zero."
