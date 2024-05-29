


 #FROM nginx:alpine
#COPY index.html /usr/share/nginx/html
#EXPOSE 80
FROM ubuntu:latest

# Update and Upgrade Packages
RUN apt-get -y update
RUN apt-get -y upgrade

# Install nano, python, pip
RUN apt-get install -y nano
RUN apt-get install -y python-is-python3
RUN apt-get install -y python3-pip

# Install Flask
RUN pip install flask

# Install gunicorn

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y python3-pip
RUN pip install -U gunicorn
RUN pip install -Ur requirements.txt
RUN gunicorn -b :3000 wsgi
# Install Curl
RUN apt-get -y update; apt-get -y install curl


FROM postgres:9.4
RUN psql -h localhost -U postgres < db/rates.sql
RUN psql -h localhost -U postgres -c "SELECT 'alive'"
FROM python 
WORKDIR /rates
COPY * ./rates
CMD ["python3","config.py","rates.py","wsgi.py"]
FROM python:3-alpine

RUN apk add --update git bash curl unzip zip openssl make

ENV TERRAFORM_VERSION="0.12.28"

RUN curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
  rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN pip install awscli boto3

ENTRYPOINT ["terraform"]