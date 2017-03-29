## Setting Up Dev Environment for Yggdrasil for the First Time:
You only need to do this once for setting up.

*Setting it up with install script*
1. Download Docker for OSX at https://store.docker.com/editions/community/docker-ce-desktop-mac?tab=description
1. Make new project folder, cd into it
1. Make sure Python 2.7+ (3.0 not supported yet) is installed by running `python --version` in terminal.
1. Make sure Pip is installed by running `pip --version` in terminal.
1. Make sure yggdrasil_dev.sh, server.py and server.pyc are copied into the directory.
1. run `./yggdrasil_dev.sh` in your project folder.
1. Yggdrasil webapp server should be running at localhost:8000 with 4000 as telnet port.
1. Start developing in the /yggdrasil game folder.

This uses Docker to run a containerized Yggdrasil app.  For subsequent dev workflows after the initial install script, navigate to the /yggdrasil directory and run `docker run -it -p 8000-8001:8000-8001 -p 4000:4000 -v ${PWD}:/usr/src/game lorecrafting/yggdrasil`


*Setting it up manually*
1. Download Docker for OSX at https://store.docker.com/editions/community/docker-ce-desktop-mac?tab=description
1. Make sure Python 2.7+ (3.0 not supported yet) is installed by running `python --version` in terminal.
1. Make sure Pip is installed by running `pip --version` in terminal.
1. Create a new folder for the entire project
1. Navigate to the project folder in the terminal
1. `pip install virtualenv`
1. `git clone https://github.com/evennia/evennia.git`
1. `git clone https://github.com/Lorecraft-Studios/yggdrasil.git`
1. `pip install -e evennia`
1. `virtualenv pyenv`
1. `source pyenv/bin/activate`
1. `cd yggdrasil`
1. put the settings.py and settings.pyc file you got from an admin into /server/conf folder - this file contains sensitive config data that is not checked into source control.
1. In /yggdrasil directory, `cd server && mkdir logs && touch server.log portal.log http_requests.log`
1. `evennia migrate`
1. In /yggdrasil directory, `docker run -it -p 8000-8001:8000-8001 -p 4000:4000 -v ${PWD}:/usr/src/game lorecrafting/yggdrasil`
1. Yggdrasil webapp server should be running at localhost:8000 with 4000 as telnet port
1. Start developing in the /yggdrasil game folder.

## Development workflow:
1. Check to make sure a local containerized Yggdrasil app is running by doing `docker ps` in the terminal
1. If not, navigate to /yggdrasil game directory and run `docker run -it -p 8000-8001:8000-8001 -p 4000:4000 -v ${PWD}:/usr/src/game lorecrafting/yggdrasil`1. Go to localhost:8000 and login as superuser
1. Modify code in the /yggdrasil game directory
1. @reload in-game as superuser for local game to reflect code changes
1. After testing and satisfied with results, check code into remote repository
1. On production instance, do a @reload as superuser and it should automatically pull the latest changes from github and reload the server with those changes.

## Setting up Yggdrasil on production servers:
1. SSH into CoreOS instance
1. `docker run -d -it -p 8000-8001:8000-8001 -p 4000:4000 lorecrafting/yggdrasil`
1. `docker ps` to get the container_id of the running Yggdrasil container
1. `docker exec <container_id> git remote add origin https://github.com/Lorecraft-Studios/yggdrasil.git`
1. `docker exec <container_id> git pull origin master`
1. To tail Yggdrasil logs `docker logs -f <container_id>

### Todo:
* Move adding remote repository info, keys and secrets to Yggdrasil's Dockerfile using env variables
* Need to find a better flow for incorporate Evennia library upstream changes - currently its just rebuilding the container and manually redeploying
* Find a way to provide DB data integrity between prod dev and new dev environments - New super user needs to be set up in the DB after every new dev install

### Notes:
* Sometimes when you restart a container in local dev environment it will say server or portal PID already exists.  You can delete server.pid and portal.pid in the /server folder, then restart the container to remedy this situation.

### Sources:
https://github.com/evennia/evennia/wiki/Getting-Started
https://github.com/evennia/evennia/wiki/Running%20Evennia%20in%20Docker
