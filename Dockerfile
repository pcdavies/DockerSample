FROM python:3

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt ./

# Debian
RUN apt-get update && apt-get install -y freetds-dev freetds-bin tdsodbc unixodbc-dev \
 && apt-get clean -y

# Debian
RUN echo "[FreeTDS]\n\
Description = FreeTDS unixODBC Driver\n\
Driver = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so\n\
Setup = /usr/lib/x86_64-linux-gnu/odbc/libtdsS.so" >> /etc/odbcinst.ini

RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /usr/src/app/progsnowcmdb
RUN mkdir -p /usr/src/app/progressive-configs

COPY progsnowcmdb/ ./progsnowcmdb/
COPY progressive-configs/ ./progressive-configs/

WORKDIR /usr/src/app/progsnowcmdb
