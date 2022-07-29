# https://www.tutorialspoint.com/makefile/makefile_example.htm
# https://opensource.com/article/18/8/what-how-makefile
# https://www.gnu.org/software/make/manual/make.html
# https://github.com/Respect/samples/blob/master/Makefile
# https://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/
# https://docs.freebsd.org/en/books/porters-handbook/makefiles/
# https://www.shellhacks.com/yes-no-bash-script-prompt-confirmation/

# Define required macros here
SHELL = /bin/sh

clear-containers:
	@echo "Removing Containers"
	docker ps --filter status=running
	#docker kill $(docker ps -q)
	#sudo docker ps -q | xargs docker kill
	docker stop $(docker ps --filter status=running -q)
	docker rm $(docker ps --filter status=exited -q)
	docker rm -f $(docker ps -aq)

remove-containers:
	@echo "Removing stopped containers"
	#@echo "y" | docker container prune
	docker container prune

remove-volumes:
	@echo "Removing all volumes"
	docker volume rm $(docker volume ls -q)

remove-images:
	@echo "Removing all images"
	docker rmi $(docker images -q)

stop:
	@echo "Stopping docker"
	#sudo service docker stop
	sudo systemctl stop docker

start:
	@echo "Starting docker"
	#sudo service docker start
	sudo systemctl start docker

show-images:
	sudo docker images

stop-local-services:
	sudo service apache2 stop
	sudo service mysql stop

