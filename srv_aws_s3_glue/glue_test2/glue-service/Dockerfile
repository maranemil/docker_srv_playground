FROM amazon/aws-glue-libs:glue_libs_3.0.0_image_01
USER root
RUN echo 'root:root' | chpasswd
RUN yum update -y
RUN yum install -y ping telnet sudo wget libaio

#WORKDIR /opt/oracle
RUN wget https://download.oracle.com/otn_software/linux/instantclient/218000/oracle-instantclient-basic-21.8.0.0.0-1.x86_64.rpm
RUN rpm -i oracle-instantclient-basic-21.8.0.0.0-1.x86_64.rpm

WORKDIR /home/glue_user
USER glue_user
CMD ["./jupyter/jupyter_start.sh"]


# Auth as root
# user root / pass root

# su
# Password:
# bash-4.2# yum update
# Loaded plugins: ovl, priorities
# amzn2-core
