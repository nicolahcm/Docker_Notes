We always start from a docker file/ docker compose --> Image --> Container. 

A DockerFile typically start with "FROM". Then it is specified the image that we want to pull from, and from which registry (for example docker hub or aws hub, etc..). 
Our container will start with such specifications of such image. After this there can be changes. 
The command RUN is to run some command in the bash/shell of the container. 

`docker ps` gives you all the containers running. With the flag --all you get all the containers, also those not running. 
