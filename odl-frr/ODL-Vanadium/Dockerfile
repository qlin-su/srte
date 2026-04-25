FROM eclipse-temurin:21-jre-jammy

RUN apt-get update && apt-get install -y wget iproute2 iputils-ping && apt-get clean

RUN wget -q https://nexus.opendaylight.org/content/repositories/opendaylight.release/org/opendaylight/integration/karaf/0.23.0/karaf-0.23.0.tar.gz -O /tmp/odl.tar.gz && \
    mkdir -p /opt/opendaylight && \
    tar -xzf /tmp/odl.tar.gz -C /opt/opendaylight --strip-components=1 && \
    rm /tmp/odl.tar.gz

EXPOSE 8181 1790 4189

WORKDIR /opt/opendaylight

CMD ["./bin/karaf", "clean"]
