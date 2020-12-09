FROM maven:3.6-openjdk-11
COPY src /tmp/src
COPY pom.xml /tmp/pom.xml
COPY containerbuild.sh /tmp/containerbuild.sh
RUN cd /tmp && mvn -DskipTests --fail-never install 
ENTRYPOINT /tmp/containerbuild.sh
