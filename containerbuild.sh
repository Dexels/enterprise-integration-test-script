#!/bin/sh
cd /tmp
mvn test
res=$?
cp target/surefire-reports/* /surefire-reports
return $res