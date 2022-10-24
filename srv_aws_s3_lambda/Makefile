# Define required macros here
SHELL = /bin/sh


up:
	echo 'start docker container build up'
	docker-compose -f aws_lambda1.yml up -d

add-s3-pqt:
	echo 'adding s3 files'
	bash add_s3_data.sh

down:
	echo 'stop docker container'
	docker-compose -f aws_lambda1.yml down --remove-orphans --rmi local

remove-img:
	docker rm image aws-lambda-python_demo

test-lambda:
	curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{}'

update-app:
	docker cp aws-lambda-python_demo/app/app.py aws-lambda-python_demo:/var/task