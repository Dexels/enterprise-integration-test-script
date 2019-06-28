#!/bin/sh
cd /tmp
mvn test
cp target/surefire-reports/* /surefire-reports
