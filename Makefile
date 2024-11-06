COMPOSE_FILE = docker-compose.yml

up:
	docker-compose -f $(COMPOSE_FILE) up -d

down:
	docker-compose -f $(COMPOSE_FILE) down

restart:
	docker-compose -f $(COMPOSE_FILE) down
	docker-compose -f $(COMPOSE_FILE) up -d

logs:
	docker-compose -f $(COMPOSE_FILE) logs -f

exec:
	docker-compose -f $(COMPOSE_FILE) exec $(service) $(cmd)

clean:
	docker-compose -f $(COMPOSE_FILE) down -v --rmi all
