FROM amazoncorretto:8-alpine-full AS builder
RUN apk add git
RUN git clone https://github.com/openstreetmap/osmosis.git  /osmosis
WORKDIR /osmosis
RUN ./gradlew assemble

FROM amazoncorretto:8-alpine-jre AS deploy
COPY --from=builder /osmosis/package /opt/osmosis
RUN ln -s /opt/osmosis/bin/osmosis /usr/local/bin/osmosis
