FROM openjdk:8-jre

ENV ACTIVEMQ_TCP=61616 ACTIVEMQ_AMQP=5672 ACTIVEMQ_STOMP=61613 ACTIVEMQ_MQTT=1883 ACTIVEMQ_WS=61614 ACTIVEMQ_UI=8161
ENV ACTIVEMQ_HOME /opt/activemq

COPY apache-activemq-5.15.9 /opt 

RUN ln -s /opt/$ACTIVEMQ $ACTIVEMQ_HOME \
    && useradd -r -M -d $ACTIVEMQ_HOME activemq \
    && chown -R activemq:activemq /opt/$ACTIVEMQ \
    && chown -h activemq:activemq $ACTIVEMQ_HOME 

USER activemq

WORKDIR $ACTIVEMQ_HOME
EXPOSE $ACTIVEMQ_TCP $ACTIVEMQ_AMQP $ACTIVEMQ_STOMP $ACTIVEMQ_MQTT $ACTIVEMQ_WS $ACTIVEMQ_UI

CMD ["/bin/sh", "-c", "bin/activemq console"]
