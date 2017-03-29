#!/bin/bash
# settings.py and settings.pyc need to be in the root project directory for this script to work

pip install virtualenv;
git clone https://github.com/evennia/evennia.git;
git clone https://github.com/Lorecraft-Studios/yggdrasil.git;
pip install -e evennia;
virtualenv pyenv;
source pyenv/bin/activate;
cd yggdrasil;
cd server;
mkdir logs;
cd logs;
touch server.log;
touch portal.log;
touch http_requests.log;
cd ../..;
mv ../settings.py server/conf/;
mv ../settings.pyc server/conf/;
evennia migrate;
docker run -it -p 8000-8001:8000-8001 -p 4000:4000 -v ${PWD}:/usr/src/game lorecrafting/yggdrasil;

