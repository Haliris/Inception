COMPOSE_FILE = srcs/docker-compose.yml
MARIADB_VOLUME = /home/jteissie/data/mariadb
WP_VOLUME = /home/jteissie/data/wordpress

create_volume_dirs:
	@mkdir -p $(MARIADB_VOLUME)
	@mkdir -p $(WP_VOLUME)

up: create_volume_dirs
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
	docker system prune -a -f
	#docker volume rm mariadb wordpress
	@ sudo rm -rf $(MARIADB_VOLUME)
	@ sudo rm -rf $(WP_VOLUME)
