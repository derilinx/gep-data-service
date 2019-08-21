NODE_OPTS=-w "/usr/src" --rm -v "$(realpath .):/usr/src"
NODE_IMAGE=node:8
NPM=docker run $(NODE_OPTS) -ti $(NODE_IMAGE) npm

DC=docker-compose -f docker-compose-local.yml

install:
	$(NPM) install

init-dev-db:
	$(DC) exec postgresql psql -U postgres -c "create user gep_data_service_dev;" template1
	$(DC) exec postgresql psql -U postgres -c "create database gep_data_service_dev" template1
	$(DC) run --rm node sh -c "npm run migrate-dev-db && npm run seed-dev-db"

bash:
	$(DC) exec node bash

psql:
	$(DC) exec postgresql bash
