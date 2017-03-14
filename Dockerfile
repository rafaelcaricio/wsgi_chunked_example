FROM ubuntu:16.10

RUN apt-get update \
 && apt-get install -q -y --no-install-recommends python3.5 python3.5-dev python3-pip python3-setuptools python3-wheel gcc m4 build-essential libssl-dev libffi-dev \
 && apt-get upgrade -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.5 1 \
    && update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 1 \
    && update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

RUN pip install flask uwsgi

COPY simple_app.py /
COPY uwsgi.yaml /

RUN mkdir /configs
COPY nginx.conf /configs

CMD uwsgi --yaml uwsgi.yaml
