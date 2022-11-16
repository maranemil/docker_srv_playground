
build:
	sam build --use-container

start:
	sam local start-api --skip-pull-image

invoke:
	sam local invoke --skip-pull-image

start-lambda:
	sam local start-lambda

invoke2:
	aws lambda invoke --function-name "HelloWorldFunction" --payload '{ "name": "Bob" }' --no-verify-ssl response.json --endpoint-url "http://localhost:3001"
