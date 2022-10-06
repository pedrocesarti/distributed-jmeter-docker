:rotating_light: This project is outdated/abandoned/archived and will not be updated anymore. :rotating_light:

-------------


# Distributed JMeter - Docker

Apache Jmeter™ is an open source tool that helps creating and running load test plans. And this Docker image was created to help you running different versions of JMeter in a Docker container, also helping you running in a distributed fashion (master -> server approach).

## Supported tags

The [Dockerfile](https://github.com/pedrocesar-ti/distributed-jmeter-docker/blob/master/Dockerfile) here is managed and built with arguments what helps building and pushing our JMeter images for all versions of JMeter available. If you want more information, have a look on the [Makefile](https://github.com/pedrocesar-ti/distributed-jmeter-docker/blob/master/Makefile).

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
- 3.3
- 4.0
- 5.4, latest

## Running Master or Server

### Master

```sh
docker run -p 60000:60000 -v <TEST_PLAN_LOCAL>:<TEST_PLAN_CONTAINER> -d pedrocesarti/jmeter-docker:latest master
```

### Server

```sh
docker run -p 1099:1099 -p 50000:50000 -v /Users/mookkiahm/git/github/distributed-jmeter-docker/rmi_keystore.jks:/jmeter/apache-jmeter-5.0/bin/rmi_keystore.jks -d pedrocesarti/jmeter-docker:latest server
```

Example to supply JMeter and JVM arguments

```sh
docker run -p 1099:1099 -p 50000:50000 -d  -v /Users/mookkiahm/git/github/distributed-jmeter-docker/rmi_keystore.jks:/jmeter/apache-jmeter-5.4/rmi_keystore.jks pedrocesarti/jmeter-docker:5.4 server
docker run -p 1099:1099 -p 50000:50000 -d  -e JMETER_SERVER_ADDITIONA_ARGS="-Jserver.rmi.ssl.disable=true" -e JVM_ARGS="-Xms300M" pedrocesarti/jmeter-docker:5.4 server
```

## Running Master and Server (Docker Compose)

You can also create a whole stack with master and servers to run a distributed JMeter tests locally or in a Docker Swarm Cluster. Check out this [docker-compose.yml](https://github.com/pedrocesar-ti/distributed-jmeter-docker/blob/master/local/docker-compose.yml) to see one example of this infra running locally.
This example is going to create a master and a server container running locally, and you can also scale up and down the number servers instancesrunning.

```sh
docker-compose up -d
docker-compose scale server=5
```

## Volumes

Another good point to mention here is that we suggest that you use volumes to share your test plans with the master container and once you have your test plans on your master container, you only going to need exec:

```sh
jmeter -n -t script.jmx -R server1,server2,…
```

You can also use this [docker-compose](https://github.com/pedrocesar-ti/distributed-jmeter-docker/blob/master/local/docker-compose.yml) to deploy in a Docker Swarm cluster defining better techniques to scale the number of replicas you want for each service and add all power of the internal discovery service.

## K8s

For the Kubernetes support, also have a look at the official helm/[chart](https://github.com/helm/charts/tree/master/stable/distributed-jmeter) repository.

Enjoy! :)
