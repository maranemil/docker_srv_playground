
build:
	sam build -u

start:
	sam local start-api

invoke:
	sam local invoke

start-lambda:
	sam local start-lambda

invoke2:
	aws lambda invoke --function-name "HelloWorldFunction" --payload '{ "name": "Bob" }' --no-verify-ssl response.json --endpoint-url "http://localhost:3001"
