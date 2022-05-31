rundeck Docker Zoo:

https://github.com/rundeck/docker-zoo/tree/master/config


Running Docker command with H2 and default config
docker run -d -p 4440:4440 -e RUNDECK_GRAILS_URL='http://localhost:4440' --name rundeck rundeck/rundeck:4.2.1