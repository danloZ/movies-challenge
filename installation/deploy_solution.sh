#!/bin/bash

echo "Downloading base images"
docker pull postgres:15.1
docker pull jupyter/pyspark-notebook:spark-3.1.2

echo "Building application image"
docker build -f ../Dockerfile -t jupyter-app:v1.0 .

echo "Building the cluster"
docker-compose -f ../docker-compose.yml up -d

echo "Enjoy!"
echo "Open the browser and go to localhost:8888, insert password 'jovyan' and run the notebook"