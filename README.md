docker-selenium
===============

This repository is the source of `tvial/selenium` which brings:    
- a basic shell with oh-my-zsh  
- firefox  
- selenium server that can be used as server, hub and node.  
- xvfb to make things run witout a started X env.    

## Why using this image?

Because it's one of the simplest and most configurable image that you will find about selenium:  
- you choose the ports on which will run you selenium grid (hub and node)  
- you choose the display  
- you provide your own selenium arguments or config files  

This image is used in a professional environnement.

## Install

    docker pull tvial/selenium

## Grid example

This is how you can easily run a selenium grid in detached mode (using `-d`):  

### Start the hub

    docker run -t -i -d --expose 4444 --name hub -p 4444:4444 tvial/selenium java -jar selenium-server/selenium-server-standalone-2.41.0.jar -role hub -port 4444

This command can be adapted to your needs.

### Start the node

Place YOUR-NODE-CONFIG.json in th folder from wich you plan to start the container and:

    docker run -t -i -d --link hub:node --name node -v $(pwd):/home/selenium/data:r tvial/selenium /bin/zsh -c 'DISPLAY=:99 xvfb-run java -jar selenium-server/selenium-server-standalone-2.41.0.jar -role node -nodeConfig /home/selenium/data/linux-firefox.json'

This command can be adapted to your needs.

## Build

If you need adapt the project to your needs, clone, modify the `Dockerfile` and from the source directory, run:

    docker build -t tvial/selenium .

