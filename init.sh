#! /bin/bash
set -e

yum update -y

yum install java-1.8.0-openjdk.x86_64 -y
java -version

amazon-linux-extras install docker  -y
service docker start
docker ps

docker pull postgres
docker images
docker run --name pg -e  POSTGRES_PASSWORD=aquercus -p 5432:5432 -d postgres
docker logs pg

docker ps -a
systemctl enable  docker.service

git clone https://github.com/aquercus/DBautomation.git /tmp/DBautomation

pushd /tmp/DBautomation/
./init.sh
popd

curl -L https://github.com/aquercus/movies/releases/download/v1.0.0/movie-0.0.1-SNAPSHOT.jar --output /tmp/movie-0.0.1-SNAPSHOT.jar
export DATABASE_PASSWORD=aquercus
java -jar /tmp/movie-0.0.1-SNAPSHOT.jar