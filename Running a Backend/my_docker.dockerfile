FROM public.ecr.aws/docker/library/python:3.10.13-bookworm

COPY requirements.txt requirements.txt
COPY server.py server.py
RUN apt-get update && apt-get install -y jq 
RUN chmod 777 server.py
RUN pip install -r requirements.txt

