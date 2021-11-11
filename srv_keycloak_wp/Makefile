# https://www.tutorialspoint.com/makefile/makefile_example.htm
# https://opensource.com/article/18/8/what-how-makefile

# Define required macros here
SHELL = /bin/sh

composer-up:
	@echo "Starting Keycloak"
	sudo docker-compose -f keycloak1.yml up -d --remove-orphans

composer-down:
	@echo "Stopping Keycloak"
	sudo docker-compose -f keycloak1.yml down --remove-orphans