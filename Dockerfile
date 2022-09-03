FROM python:3.8-slim

WORKDIR /opt/src

COPY requirements.txt requirements.txt

RUN  apt-get update \
  && apt-get install -y wget

RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

ENTRYPOINT [ "python","inference.py"]