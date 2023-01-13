# Prerequisites


# Installation

docker pull postgres:15.1

docker pull jupyter/pyspark-notebook:python-3.10.8

cd <repo-directory-path>
docker build -f Dockerfile-jupyter -t jupyter-app:v1.0 .