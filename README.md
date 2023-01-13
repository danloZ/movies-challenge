# Prerequisites
- Docker engine

# Installation

Download Rancher desktop
https://docs.rancherdesktop.io/getting-started/installation/

docker pull postgres:15.1

docker pull jupyter/pyspark-notebook:python-3.10.8

cd <repo-directory-path>
docker build -f Dockerfile-jupyter -t jupyter-app:v1.0 .
