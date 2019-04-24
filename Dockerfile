FROM maven:latest
COPY src /tmp/src
COPY pom.xml /tmp/pom.xml
COPY containerbuild.sh /tmp/containerbuild.sh
RUN cd /tmp && mvn --fail-never install 
ENTRYPOINT /tmp/containerbuild.sh
