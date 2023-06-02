FROM elasticsearch:7.14.0

HEALTHCHECK --start-period=20s CMD curl -u elastic:$ELASTIC_PASSWORD -s http://localhost:9200/_cluster/health | grep green || exit 1

EXPOSE 9200 9300

# settings  timezone
ENV TZ Asiza/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Switch to the root user so we can install packages and configure the system
USER root
# Copy the cert_options.yml file into the Docker image
COPY config/cert_options.yml /usr/share/elasticsearch/config/certs/cert_options.yml
# Run the elasticsearch-certutil command to generate certificates
RUN bin/elasticsearch-certutil ca --out /usr/share/elasticsearch/config/certs/elastic-stack-ca.p12 --pass "" --silent
RUN bin/elasticsearch-certutil cert --in /usr/share/elasticsearch/config/certs/cert_options.yml --ca /usr/share/elasticsearch/config/certs/elastic-stack-ca.p12 --ca-pass "" --pass "" --out /usr/share/elasticsearch/config/certs/elastic-certificates.p12 --silent

# Change the ownership and permissions of the certificate files
RUN chown elasticsearch:elasticsearch /usr/share/elasticsearch/config/certs/*
RUN chmod 600 /usr/share/elasticsearch/config/certs/*
# Switch back to the elasticsearch user
USER elasticsearch

# copy plugins
COPY plugins /usr/share/elasticsearch/plugins
