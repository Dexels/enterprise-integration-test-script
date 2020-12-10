### Test setup for Navajo

Run as maven test:

```
mvn test
```

By default the tests will look for a navajo server at `http://navajo:8181`. The tests expect a running navajo instance
with test data as provided by the [navajo-basic-environment](https://github.com/Dexels/navajo-basic-environment) repository.
The `navajo-basic-environment` repository provides a script `run.sh`, which uses docker-compose to start the required
containers, in the appropriate docker network.

Alternatively, you can run the navajo instance in a local Eclipse workspace. In which case you need to supply the tests
the appropriate system property:

```
mvn test -Dnavajo.address=http://localhost:9090
```

The tests use the Karate framework. See:
* https://github.com/intuit/karate/
* https://www.youtube.com/watch?v=yu3uupBZyxc
