FROM debian:sid

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y gdal-bin \
  libgdal-dev

RUN apt install -y python3 \
  python3-pip \
  python3-venv \
  python3-dev \
  build-essential \
  libssl-dev \
  libffi-dev

RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin

WORKDIR /usr/src/app

COPY . .

# Create virtual environment
RUN python3 -m venv .venv

RUN .venv/bin/python3 -m pip install --upgrade pip
RUN .venv/bin/pip install -r requirements.txt

EXPOSE 8080

CMD [".venv/bin/jupyter", "lab", "--port", "8080", "--ip", "0.0.0.0"]
