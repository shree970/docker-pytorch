FROM python:3.8-slim

WORKDIR /opt/src

COPY requirements.txt requirements.txt

RUN  apt-get update \
  && apt-get install -y wget
#RUN apt install libjpeg62 libjpeg62-dev python-imaging build-dep 

#RUN apt-get install libtiff5-dev libjpeg8-dev libopenjp2-7-dev zlib1g-dev \
#    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python3-tk \
#    libharfbuzz-dev libfribidi-dev libxcb1-dev

# RUN apt-get update && apt-get install -y \
#         python-setuptools \
#         libffi-dev libxml2-dev libxslt1-dev \
#         libtiff4-dev libjpeg8-dev zlib1g-dev libfreetype6-dev \
#         liblcms2-dev libwebp-dev tcl8.5-dev tk8.5-dev python-tk

# RUN apt-get build-dep python-imaging
# RUN apt-get install libjpeg62 libjpeg62-dev

#RUN apt-get install libjpeg-dev libfreetype6 libfreetype6-dev zlib1g-dev
#RUN pip install numpy==1.18.1
RUN pip3 install --no-cache-dir https://download.pytorch.org/whl/cpu/torch-1.12.0%2Bcpu-cp38-cp38-linux_x86_64.whl
RUN pip3 install --no-cache-dir https://download.pytorch.org/whl/cpu/torchvision-0.13.1%2Bcpu-cp38-cp38-linux_x86_64.whl
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

ENTRYPOINT [ "python","inference.py"]

