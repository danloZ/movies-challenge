FROM jupyter/pyspark-notebook:spark-3.1.2

ENV PYSPARK_SUBMIT_ARGS --master local[*] pyspark-shell
ENV PYTHONPATH=$SPARK_HOME/python:$PYTHONPATH
ENV PYSPARK_DRIVER_PYTHON="jupyter"
ENV PYSPARK_DRIVER_PYTHON_OPTS="lab"
ENV PYSPARK_PYTHON=python3
ENV PATH=$SPARK_HOME:$PATH:~/.local/bin:$JAVA_HOME/bin:$JAVA_HOME/jre/bin

WORKDIR ${HOME}

COPY ./requirements.txt ./
COPY storage ${HOME}/work
COPY jars ${SPARK_HOME}/jars
COPY jupyter_notebook_config.json ${HOME}/.jupyter/jupyter_notebook_config.json

USER 0
RUN apt-get update && \
    apt-get -y install nano wget curl gzip && \
    chmod -R 777 /home/jovyan/work
USER jovyan

# open conda shell
SHELL ["conda", "run", "-v", "-n", "base", "/bin/bash", "-c"]
RUN pip install -r requirements.txt
SHELL ["/bin/bash", "-c"]

# expose port 8080 for spark UI
EXPOSE 4040 8888 7077


