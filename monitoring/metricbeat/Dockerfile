FROM docker.elastic.co/beats/metricbeat:8.12.0

# Copy the metricbeat.yml file over
COPY ./nginx/beat.yml /usr/share/metricbeat/metricbeat.yml

# Run as root, otherwise the docker daemon is not accessible
USER root
