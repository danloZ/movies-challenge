# Prerequisites
- Docker engine
- Docker-compose

# Installation

This solution runs on Docker platform. To make the installation process as smooth as possible, you will need to make it run through one of following tools:
- Rancher Desktop: an open-source desktop application that enables Docker containers management on top of kubernetes clusters. Docker-compose plugin is bundled; it does not need any purchasable license for use (that may happen if you use Docker Desktop).Download Rancher desktop from here and follow [installation guide](https://docs.rancherdesktop.io/getting-started/installation/). Be careful, you should choose the CLI called Moby (dockerd) in roder to deploy containers and run the script
- Docker engine + Docker-compose: essential and lightweight solution; you can either follow the installation guide on the [official website](https://docs.docker.com/engine/install/) or run the following command
````bash
sh ./installation/installation.sh
````


Now that you've set up the docker platform, you just need to deploy the containers.
Deploy docker containers via this command:
````bash
sh ./installation/deploy_solution.sh
````

- Now open your favourite browser, go to http://localhost:8888/
- Insert password 'jovyan' to access the notebook
- Run the entire notebook and enjoy!

# Run Postgres client from the docker container [optional]
Open bash terminal and run 
````bash
docker exec -it postgres-db /bin/bash
````
Now that you accessed the running container, run the client
````bash
psql -U postgres
````
Run sample queries like the following:
````bash
CREATE DATABASE movies;
\c movies
SELECT * FROM Top100byRatio;
````

# Install Postgres client [optional]
Open terminal and run 
````bash
sudo apt install postgresql-client
````
Open terminal and run client:
````bash
psql -h localhost -p 5432 -U postgres -W postgres
````
Run sample queries like the previous case

# How to run the script
As mentioned in the installation description, the script is implemented on a notebook running in jupyterlab environment. The environment includes:
- Python 3.10.8
- Pyspark 3.1.2
- Additional jars to use Spark JDBC Connector for Postgres and Spark Connector for XML: find all jars in /jars folder
- Pandas
- Psycopg2 for pythonic Postgres client

You can do one-shot run of entire notebook by clicking the fast-forward button on the control bar.
The main script is implemented with Pyspark, reading/writing from parquet,csv,xml and postgres using the connectors provided. In this way we keep the same implementation of script regardless of the data structures of the variuos sources.
In the case of postgres, I have used the pythonic library psycopg2 to create the database, then I wanted to leave an example of query that can be done with pandas, that can be easily converted to Spark Dataframe.

My choice of using Spark enables this script to be easily scalable by  changing the cluster configuration (spark.conf) from local (now) to client/cluster mode. The choice of local cluster deployment is due to the need of shared filesystem required to run workers on multiple containers: this configuration would have made the deployment process more tricky since it needs to mount local filesystem to directories inside the containers. 

# Test
In order to test the data loaded on postgres, we can compare the data coming from top100byRatio table to the data from parquet file

# Troubleshooting
## I cannot build the image from Dockerfile
You can load the image from the file image/jupyter-app_v1.0.tar
````bash
docker image load -i image/jupyter-app_v1.0.tar
````
If you already pulled the postgres image, proceed with docker-compose command that you find in /installation/deploy_solution.sh
## jupyterlab does not run when I deploy the container
Open terminal
````bash
docker exec -it jupyter-app /bin/bash
````
Now that you accessed the running container: 
````bash
conda run -n base jupyter-lab --no-browser --ip=0.0.0.0 --port=8888 --allow-root
````
Now open your favourite browser, go to http://localhost:8888/ and insert password 'jovyan' to access the notebook
## The cell that creates the sparkSession generates some warnings
It is due to the way the python kernel access the sparkSession. It will not influence the way you work
