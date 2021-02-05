FROM openjdk:8-jre-slim
ARG JMETER_VERSION

ENV JMETER_VERSION ${JMETER_VERSION:-5.4}
ENV JMETER_HOME /jmeter/apache-jmeter-$JMETER_VERSION/
ENV PATH $JMETER_HOME/bin:$PATH

# INSTALL PRE-REQ
RUN apt-get update && \
    apt-get -y install \
    wget 

# INSTALL JMETER BASE 
RUN mkdir /jmeter
WORKDIR /jmeter

RUN wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz && \
    tar -xzf apache-jmeter-$JMETER_VERSION.tgz && \
    rm apache-jmeter-$JMETER_VERSION.tgz

WORKDIR $JMETER_HOME 

COPY config/user.properties bin/user.properties

COPY scripts/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE 6000 1099 50000
ENTRYPOINT ["/docker-entrypoint.sh"]
