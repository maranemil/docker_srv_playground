FROM ubuntu:18.04

# -- Install Pipenv:
FROM python:3
ENV PYTHONUNBUFFERED 1

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# -- Install Application into container:
RUN set -ex && mkdir /app

WORKDIR /app
ADD requirements.txt /app/

RUN pip install -r requirements.txt

# -- Adding dependencies:
ADD . /app/