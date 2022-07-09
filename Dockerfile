ARG JAVA_VERSION=18

FROM gradle:jdk$JAVA_VERSION-alpine AS builder
RUN apk add git
RUN git clone https://github.com/openstreetmap/osmosis.git  /osmosis
WORKDIR /osmosis
RUN ./gradlew assemble

FROM openjdk:$JAVA_VERSION-alpine AS deploy
COPY --from=builder /osmosis/package /opt/osmosis
RUN ln -s /opt/osmosis/bin/osmosis /usr/local/bin/osmosis
