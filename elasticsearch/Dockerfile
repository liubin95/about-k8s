FROM elasticsearch:7.14.0

HEALTHCHECK --start-period=20s CMD curl -u elastic:$ELASTIC_PASSWORD -s http://localhost:9200/_cluster/health | grep green || exit 1

EXPOSE 9200 9300

# settings  timezone
ENV TZ Asiza/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


# Switch to the root user so we can install packages and configure the system
USER root

# Run the elasticsearch-certutil command to generate certificates
RUN bin/elasticsearch-certutil ca --out /usr/share/elasticsearch/config/certs/elastic-stack-ca.p12 --pass ""
RUN bin/elasticsearch-certutil cert --name elasticsearch --dns elasticsearch --ca /usr/share/elasticsearch/config/certs/elastic-stack-ca.p12 --pass "" --out /usr/share/elasticsearch/config/certs/elastic-certificates.p12

# Switch back to the elasticsearch user
USER elasticsearch

# copy plugins
COPY plugins /usr/share/elasticsearch/plugins
