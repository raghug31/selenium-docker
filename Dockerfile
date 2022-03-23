FROM amazoncorretto:11.0.14-alpine3.15

RUN apk add curl jq

# Workspace
WORKDIR /usr/share/udemy

# ADD .jar under target from host
# into this image
ADD target/selenium-docker.jar 			selenium-docker.jar
ADD target/selenium-docker-tests.jar 	selenium-docker-tests.jar
ADD target/libs							libs

# in case of any other dependency like .csv / .json / .xls
# please ADD that as well

# ADD suite files
ADD book-flight-module.xml				book-flight-module.xml
ADD search-module.xml					search-module.xml
ADD testng.xml                          testng.xml


ADD healthcheck.sh                      healthcheck.sh
RUN dos2unix                            healthcheck.sh

# BROWSER
# HUB_HOST
# MODULE

ENTRYPOINT java -cp selenium-docker.jar:selenium-docker-tests.jar:libs/* -DBROWSER=chrome -DHUB_HOST=192.168.29.66  org.testng.TestNG search-module.xml