FROM public.ecr.aws/lambda/python:3.9
#FROM public.ecr.aws/sam/build-python3.9:latest-x86_64

#USER root
#RUN echo 'root:root' | chpasswd
RUN yum update -y
RUN yum install -y inetutils-ping telnet sudo wget libaio htop nano vim curl

#WORKDIR ${LAMBDA_TASK_ROOT}

COPY requirements.txt  .
RUN /var/lang/bin/python3.9 -m pip install --upgrade pip
RUN  pip3 install -r requirements.txt --target "${LAMBDA_TASK_ROOT}"

COPY app.py ${LAMBDA_TASK_ROOT}
CMD [ "app.handler" ]