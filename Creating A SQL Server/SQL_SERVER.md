PREREQUISITES:
- install Docker Desktop, DBeaver. 

Here we use MS SQL 

1. Pull the SQL image:

`docker pull mcr.microsoft.com/mssql/server`

2. Create and run the container 
`
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Password1!" -p 1433:1433 -v C:/DockerVolumes/SQL/voltest1/data:/var/opt/mssql/data -v C:/DockerVolumes/SQL/voltest1/log:/var/opt/mssql/log -v C:/DockerVolumes/SQL/voltest1/secrets:/var/opt/mssql/secrets --name mssqlcontainer -d mcr.microsoft.com/mssql/server:latest
`

- The flag -e is for setting environment variables
- The flag -d is for run in detached mode (i.e. background, opposite of -i --interactivve-- or -t --terminale)
- The option --name is for giving a name to the container 
- The flag -v is for setting volumes. It maps the volume on my pc C:/... into the volume of the container.
- Note: you can also use `
-v `` `pwd` ``/../data:/data
`  with pwd as working directory. The syntax - backticks or ${pwd}, etc... - might differ from cmd, powershell, etc... 
- Careful: the password should be complicated enough, otherwise the container stops and gives error. 

3. Connect from Dbeaver. Create new connection. Search for MS SQL. Should be the "SQL SERVER" first result. For the connection information specify: localhost, port 1433, and username: sa (It is the standard username of administrator in MS SQL server). Password the one used above (Password1!). 
Use some commands like:

`CREATE TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);


INSERT INTO Persons (PersonID, LastName, FirstName, Address, City)
VALUES ('1', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', 'Stockholm');

SELECT * FROM Persons p 
`

4. Try to stop the container and delete it. Then recreate it as in step 2. If you query the db, "SELECT * FROM Persons p", you will see that the entry of before is saved, thanks to the volumes that we have specified. 

-------------------------------

HOW TO RUN 2 DB AT THE SAME TIME? 

Create another container with another name, different from the one above (--name: mssqlcontainer2)
`
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=Password1!" -p 1434:1433 -v C:/DockerVolumes/SQL/voltest2/data:/var/opt/mssql/data -v C:/DockerVolumes/SQL/voltest2/log:/var/opt/mssql/log -v C:/DockerVolumes/SQL/voltest2/secrets:/var/opt/mssql/secrets --name mssqlcontainer2 -d mcr.microsoft.com/mssql/server:latest
`

- Moreover, note that we have specified different volumes in our Host computer (voltest2), while the volume path in the container is the same! 
- Finally, note that -p 8000:1433. This because our host machine will listen to port 8000 (different from the one specified above - 1433). The second argument after the column (:) is to specify that the container is listening on port 1433. The second argument after the column has always to be 1433 in this MS SQL server, because by default in the container machine, the MS SQL server is listening on that port. Probably can be changed by some environment variables.

Notice that we can have both containers running at the same time and dbeaver con connect to both. 

If we are to delete one container, the data remains in the path specified in the volume path of our host computer, C:/DockerVolumes/SQL/voltest2 or C:/DockerVolumes/SQL/voltest1. 

Next time, if we want to recover such data, is enough to create the container and run it such that the volume in our host machine is directed to the existing paths with already existing data. 

