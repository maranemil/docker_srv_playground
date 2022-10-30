FROM public.ecr.aws/lambda/python:3.9 AS compile-image
# install pip libs
COPY requirements.txt  .
RUN  pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"
ENV APP_VERSION=1.0.0

FROM public.ecr.aws/lambda/python:3.9 AS build-image
COPY --from=compile-image /var/task /var/task
ENV APP_VERSION=1.0.0
# Copy function code to /var/task
COPY app/app.py ${LAMBDA_TASK_ROOT}
CMD ["app.handler"]

