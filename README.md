# Description
This project allows Data Science enthusiast to interact with a standalone Spark Cluster using Python or R in a couple of minutes.
This project main aim is to act as sandbox for people making their first steps with Spark concepts and ***shouldn't*** be used on production environments.
The Spark cluster is running in one Spark Master and one Spark workers. (This can be changed using the docker-compose.xml file).
The Python container includes: ***Jupyter Notebook***, ***Jupyter Lab***, and a set of the most common used Data Science libraries (see all details [here](https://jupyter-docker-stacks.readthedocs.io/en/latest/index.html))
The R container include a version of ***R Studio cloud*** that can be accessed by the browser with a pre-install set of Data Science common use libraries (see all details [here](https://rocker-project.org/images/versioned/rstudio.html)).

# Prerequisites
1. Use a Linux or Mac computer.
2. Use a Docker compatible Window computer.

# Install Docker
The project uses docker containers to allow the components interactions. Follow the next steps to install
Docker in your computer. Ignore if Docker is already installed in your computer.
1. Install [Docker](https://docs.docker.com/engine/installation/)
2. Install [Docker-compose](https://docs.docker.com/compose/install/)
3. Configure Docker to be managed as non-root [user](https://docs.docker.com/engine/install/linux-postinstall/)

# Set-up Steps
The docker-compose file can be found on the ***build/*** folder. Nevertheless, a helper bash
script was created to make easier the project's setup. Give this script execution permission before using it.
```bash
chmod +rwx run.sh
```

# Build the project
This is necessary just the first time the project is used.
1. Open a terminal console an run these commands.
```bash
./run.sh build
```

# Start the project
Run the next command to start all docker containers.
1. Open a terminal console an run these commands.
```bash
./run.sh up
```

# Stop the project
Run the next command to stop all docker containers.
1. Open a terminal console an run these commands.
```bash
./run.sh down
```

# Watch container logs
The log of the containers can be reviewed by typing.
1. Open a terminal console an run these commands.
```bash
./run.sh logs
```

# Access Python and R working IDES.
The python container includes ***Jupyter Notebook***, ***Jupyter Lab***. To access them, open the container logs
and locate the Jupyter URL. Copy and paste this URL in a browser. You can also use this URL to integrate with your favorite IDE as VS Code or PyCharm.
The R container includes ***R Studio Cloud**. To access it, you can navigate directly to http://localhost:8787/ in your favorite browser.
1. R studio User: admin
2. R studio Pass: rstudio

# Working with your own data.
All files place on ***data/*** folder will be share among the Spark nodes and the Data Science containers (R and Python).
To work with your own data, just copy your files inside the ***data*** folder.

# Adding extra packages.
## Python
1. Add the package name to ***build/requirements.txt***
2. Build the project again.
```bash
./run.sh build
```

## R
1. Add the package name to ***build/Dockerfile-r***
2. Build the project again.
```bash
./run.sh build
```

# Development tips
1. To keep to code tide add all python code inside the ***python*** and all R code inside ***r***
2. Review the container logs to verify any problem during the project setup
3. You can enable sublime extension to improve you code development fluency.
4. Others JupterLab extensions are available by clicking on Settings->Enable extension manager.
5. Some of these extensions won't work right now by a problem with the default JupiterLab [extension](https://forums.aws.amazon.com/thread.jspa?threadID=332549)

## Support
For support, send an email to [fabian.hnz@gmail.com](mailto:fabian.hnz@gmail.com). I try to review the email everyday..

## Authors and acknowledgment
* Fabián Hernández: Project's main contributor.

## License
<!--- https://gist.github.com/lukas-h/2a5d00690736b4c3a7ba -->
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
