COMPOSE_FILES = -f docker-compose-third-party.yml

start:
	docker-compose $(COMPOSE_FILES) up -d --remove-orphans

stop:
	docker-compose $(COMPOSE_FILES) down --remove-orphans