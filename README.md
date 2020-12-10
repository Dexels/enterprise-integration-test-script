### Test setup for Navajo

Run as maven test:

mvn test

By default it will look for a navajo server at http://navajo:8181
(which should work if the test docker-compose is running, and we're running from a container in the same docker network)

If we want to connect somewhere else (for example running from a local Eclipse instance) we can supply it using a system property:

mvn test -Dnavajo.address=http://localhost:9090

The tests use the Karate framework. See:
* https://github.com/intuit/karate/
* https://www.youtube.com/watch?v=yu3uupBZyxc

