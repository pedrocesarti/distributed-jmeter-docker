FROM ubuntu:trusty

ENV JMETER_VERSION 3.1
ENV JMETER_HOME /jmeter/apache-jmeter-$JMETER_VERSION/
ENV PATH $JMETER_HOME/bin:$PATH

# INSTALL PRE-REQ
RUN apt-get update && \
    apt-get -y install \
    wget \
    default-jre-headless \
    telnet \
    iputils-ping \
    unzip

# INSTALL JMETER BASE 
RUN mkdir /jmeter
WORKDIR /jmeter

RUN wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz && \
    tar -xzf apache-jmeter-$JMETER_VERSION.tgz && \
    rm apache-jmeter-$JMETER_VERSION.tgz && \
    mkdir /jmeter-plugins && \
    cd /jmeter-plugins/ && \
    wget https://jmeter-plugins.org/downloads/file/JMeterPlugins-ExtrasLibs-1.4.0.zip && \
    unzip -o JMeterPlugins-ExtrasLibs-1.4.0.zip -d /jmeter/apache-jmeter-$JMETER_VERSION
    
#RUN echo "jmeter.save.saveservice.default_delimiter=\\t" >> /jmeter/apache-jmeter-$JMETER_VERSION/bin/user.properties && \
#    echo "jmeter.save.saveservice.print_field_names=true" >> /jmeter/apache-jmeter-$JMETER_VERSION/bin/user.properties

WORKDIR $JMETER_HOME 

EXPOSE 6000
CMD tail -f /dev/null
