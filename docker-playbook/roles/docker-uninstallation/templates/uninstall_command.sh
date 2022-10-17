#!/bin/bash

sudo service docker stop
sudo apt-get purge docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
