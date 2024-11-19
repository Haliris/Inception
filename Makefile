COMPOSE_FILE = srcs/docker-compose.yml
MARIADB_VOLUME = /home/jteissie/data/mariadb
WP_VOLUME = /home/jteissie/data/wordpress
UPTIMEKUMA_VOlUME = /home/jteissie/data/uptimekuma
STATIC_VOLUME = /home/jteissie/data/static-site

create_volume_dirs:
	@mkdir -p $(MARIADB_VOLUME)
	@mkdir -p $(WP_VOLUME)
	@mkdir -p $(UPTIMEKUMA_VOlUME)
	@mkdir -p $(STATIC_VOLUME)

up: create_volume_dirs
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

restart:
	docker compose -f $(COMPOSE_FILE) down
	docker compose -f $(COMPOSE_FILE) up -d

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

exec:
	docker compose -f $(COMPOSE_FILE) exec $(service) $(cmd)

clean:
	docker compose -f $(COMPOSE_FILE) down -v --rmi all
	docker system prune -a -f
	@ sudo rm -rf $(MARIADB_VOLUME)
	@ sudo rm -rf $(WP_VOLUME)
	@ sudo rm -rf $(UPTIMEKUMA_VOLUME)
	@ sudo rm -rf $(STATIC_VOLUME)
