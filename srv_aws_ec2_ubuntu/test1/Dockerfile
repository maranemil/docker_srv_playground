
################################################
# Download base image ubuntu 20.04
################################################

FROM ubuntu:22.04 as BaseImageTest
# https://www.howtoforge.com/tutorial/how-to-create-docker-images-with-dockerfile/
# https://hub.docker.com/_/ubuntu/tags

RUN apt-get update
#RUN DEBIAN_FRONTEND=noninteractive
# Install nano from ubuntu repository
RUN apt install -y nano htop python3 wget
RUN apt install -y vim
RUN apt install -y alien
RUN apt-get install python3-pip -y

RUN wget https://download.oracle.com/otn_software/linux/instantclient/218000/oracle-instantclient-basic-21.8.0.0.0-1.x86_64.rpm
RUN alien oracle-instantclient-basic-21.8.0.0.0-1.x86_64.rpm
RUN dpkg -i oracle-instantclient-basic_21.8.0.0.0-2_amd64.deb

FROM BaseImageTest as PythonTest

WORKDIR /opt
#WORKDIR /home

COPY requirements.txt .
RUN pip3 install -r requirements.txt

# Expose Port for the Application
#EXPOSE 80
#CMD ["python3 --version"]
CMD ["bash"]


# python3 --version
# Python 3.10.6