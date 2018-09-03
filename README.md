fork后进行修改，可对mysql数据卷进行映射，判断映射路径中是否存在mysql目录来决定是否执行mysql初始化操作

docker run -p 3306:3306 -v /soft/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root nsn/mysql:5.7



# MySQL on an ARMv7 docker base

Based on: https://github.com/docker-library/mysql/tree/master/5.7

## Tags
* `5.7.22`, `5.7`, `5`, `latest` [(5.7.22/Dockerfile)](https://github.com/beercan1989/docker-arm-mysql/blob/5.7.22/Dockerfile)
* `5.7.12` [(5.7.12/Dockerfile)](https://github.com/beercan1989/docker-arm-mysql/blob/5.7.12/Dockerfile)

## Source
* GitHub: https://github.com/beercan1989/docker-arm-mysql

## Running
```
docker run -it \
  -e 'MYSQL_ROOT_PASSWORD=password' \
  -e 'MYSQL_DATABASE=identity' \
  -e 'MYSQL_USER=identity' \
  -e 'MYSQL_PASSWORD=password' \
  -p '3306:3306' \
  --name example_mysql \
  beercan1989/arm-mysql:latest
```

## Building, testing, tagging, pushing
```
docker build -t beercan1989/arm-mysql:latest .

docker run -it \
  -e 'MYSQL_ROOT_PASSWORD=password' \
  -e 'MYSQL_DATABASE=identity' \
  -e 'MYSQL_USER=identity' \
  -e 'MYSQL_PASSWORD=password' \
  -p '3306:3306' \
  --name example_mysql \
  beercan1989/arm-mysql:latest

docker login

docker tag beercan1989/arm-mysql:latest beercan1989/arm-mysql:5
docker tag beercan1989/arm-mysql:latest beercan1989/arm-mysql:5.7
docker tag beercan1989/arm-mysql:latest beercan1989/arm-mysql:5.7.22

docker push beercan1989/arm-mysql:latest
docker push beercan1989/arm-mysql:5
docker push beercan1989/arm-mysql:5.7
docker push beercan1989/arm-mysql:5.7.22
```
