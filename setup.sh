#!/bin/bash
docker stop postgres1
docker rm postgres1
docker rmi postgres_img
docker build --rm=true --tag="postgres_img" .
docker run -d --name="postgres1" -p 48901:48901 -p 48902:48902 --expose=5432 postgres_img
docker ps
#rm ~/.ssh/known_hosts
#ssh -p 48901 root@localhost

