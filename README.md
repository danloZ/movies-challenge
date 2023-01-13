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

# Install Postgres client [optional]
Open terminal and run 
````bash
sudo apt install postgresql-client
````
Open terminal and run client:
````bash
psql -h localhost -p 5432 -U postgres -W postgres
````
Run sample queries like the following:
````bash
CREATE DATABASE movies;
\c movies
SELECT * FROM Top100byRatio;
````
