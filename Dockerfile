FROM python:3.9-alpine
LABEL maintainer="InnovaTech"

ENV PYTHONUNBUFFERED 1

# Install dependencies
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev \
      build-base \
      python3-dev \
      openssl-dev \
      gfortran \
      lapack-dev

RUN pip install --upgrade pip
COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

# Setup directory structure
RUN mkdir /app
WORKDIR /app
COPY ./app/ /app
RUN adduser -D user

USER user
