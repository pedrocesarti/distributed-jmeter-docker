# Distributed JMeter - Docker

Apache Jmeter™ is an open source tool that helps creating and running load test plans. And this Docker image was created to help you running different versions of JMeter in a Docker container, also helping you running in a distributed fashion (master -> server approach). 

### Supported tags

The [Dockerfile](https://github.com/pedrocesar-ti/distributed-jmeter-docker/blob/master/Dockerfile) here is managed and built with arguments what helps building  and pushing our JMeter images for all versions of JMeter available. If you want more information, have a look on the [Makefile](https://github.com/pedrocesar-ti/distributed-jmeter-docker/blob/master/Makefile).

- 3.3, latest
- 2.6
- 2.7
- 2.8
- 2.9
- 2.10
- 2.11
- 2.12
- 2.13
- 3.0
- 3.1
- 3.2
- 4.0
- 5.0 

### Running Master or Server
####Master
```sh
docker run -p 60000:60000 -v <TEST_PLAN_LOCAL>:<TEST_PLAN_CONTAINER> -d pedrocesarti/jmeter-docker:latest master
```

####Server
```sh
docker run -p 1099:1099 -p 50000:50000 -d pedrocesarti/jmeter-docker:latest server
```


### Running Master and Server (Docker Compose)
You can also create a whole stack with master and servers to run a distributed JMeter.

```sh
docker-compose up -d
```

```yaml
version: '3'
services:
  master:
    image: pedrocesarti/jmeter-docker:latest
    command: master
    tty: true
    ports:
      - "60000"
    volumes:
      - "./test/:/jmeter/sample/"
  server:
    image: pedrocesarti/jmeter-docker:latest
    command: server
    tty: true
    ports:
      - "50000"
      - "1099"
    depends_on:
      - master
```

This is going to create one master and one server running locally, but you can also scale up and down the number instances servers running.
```sh
docker-compose scale server=5
```

#### Volumes
Another good point to mention here is that we suggest that you use volumes to share your test plans with the master container and once you have your test plans on your master container, you only going to need exec:

```sh
jmeter -n -t script.jmx -R server1,server2,…
``` 

You can also use this [docker-compose](https://github.com/pedrocesar-ti/distributed-jmeter-docker/blob/master/local/docker-compose.yml) to deploy in a Docker Swarm cluster defining better techniques to scale the number of replicas you want for each service and add all power of the internal discovery service.

Enjoy! :)
