We have a simple backend server in Flask. See the file server.py. There is only the main endpoint GET /, which responds with "Hello World". The server listens to port 90. 

1. BUILD OF THE IMAGE FROM THE DOCKERFILE

`
docker build -t backendpy:tag1 -f my_docker.dockerfile .
`

- the flag -t is to say that we also specify a tag for such image. 
- The flag -f is to spacify the dockerfile from which to build the image. The final `.` is to say that the dockerfile is to be found in such folder. 
- Notes: If you look at the docker file, we always start FROM someurl_and_image_name. This will pull the public image from some public registry. Then we say to copy the file requirements.txt from such folder where we are running the dockerfile, into the container file "requirements.txt". The same with server.py

2. CREATE THE CONTAINER AND RUN IT Interactively: 

`docker run -it --name mycontainerpy -p 8000:90 backendpy:tag1 /bin/bash`

- the -it flag is to run interactively the container. The final /bin/bash works together with such flag. Is a bash/cmd/shell program. 
- With the flag --name we give to such a container a specific name. 
- the -p flag says that that in order to communicate from the host computer, I have to call localhost at port 8000. This is mapped to the port 90 of the container, where indeed python server is listening to.

Try some commands like: python --version, pip --version, ls (you can see indeed that requirements.txt and server.py have been copied in the container)

3. RUN The python server inside the shell of the container: 

`python server.py`

Now if you navigate to localhost:8000 in your host machine, you will receive the message "Hello World" 

NOTE: 

1. If you were to run the container in detached mode, then it would immediately exit, because there are no foreground processes running. Therefore, we run in interactive mode (opposite of detached). 
There was another way, and that it was to specify in the dockerfile, at the end, with the help of the command CMD, to run python server.py 

2. We could copy files/folder from our Host computer to the docker container after it was created, with the help of the command `docker cp`. Therefore, it wasn't strictly necessary to specify the copy from the dockerfile

3. If we wanted to Run 2 containers python/ 2 backend python at the same time, just create 2 containers. Give them different name, and specify different ports: `8000:90` and `8001:90` for example. In such a way, in your local Host computer you can just call localhost:8000 or localhost:8001. 