FROM jboss/base-jdk:8

ENV VERSION 10.1.0.Final
ENV SHA1 9ee3c0255e2e6007d502223916cefad2a1a5e333
ENV JBOSS_HOME /opt/jboss/wildfly
ENV JBOSS_DEPLOYMENTS $JBOSS_HOME/standalone/deployments/

RUN cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$VERSION/wildfly-$VERSION.tar.gz \
    && sha1sum wildfly-$VERSION.tar.gz | grep $SHA1 \
    && tar xf wildfly-$VERSION.tar.gz \
    && mv $HOME/wildfly-$VERSION $JBOSS_HOME \
    && rm wildfly-$VERSION.tar.gz

ENV LAUNCH_JBOSS_IN_BACKGROUND true

ADD node-info.war $JBOSS_DEPLOYMENTS
ADD showcase-6.0.war $JBOSS_DEPLOYMENTS 

EXPOSE 8080

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]\


