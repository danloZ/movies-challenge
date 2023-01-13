FROM jupyter/pyspark-notebook:spark-3.1.2

ENV PYSPARK_SUBMIT_ARGS --master local[*] pyspark-shell

WORKDIR ${HOME}

COPY ./requirements.txt ./
COPY storage ${HOME}/work
COPY jars ${SPARK_HOME}/jars
COPY jupyter_notebook_config.json ${HOME}/.jupyter/jupyter_notebook_config.json

USER 0
RUN apt-get update && \
    apt-get -y install vim wget curl gzip supervisor && \
    pip install -r requirements.txt && \
    chmod -R 777 /home/jovyan/work
USER jovyan

# expose port 8080 for spark UI
EXPOSE 4040 8888 7077


