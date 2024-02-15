FROM nginx:latest

RUN mkdir -p /app/node
WORKDIR /app

RUN apt-get update && apt-get install -y \
    wget \
    build-essential

RUN wget --no-check-certificate https://nodejs.org/dist/v20.11.0/node-v20.11.0-linux-x64.tar.xz
RUN tar -xJvf node-v20.11.0-linux-x64.tar.xz
RUN mv node-v20.11.0-linux-x64 /usr/local/node
ENV PATH="/usr/local/node/bin:${PATH}"
RUN rm node-v20.11.0-linux-x64.tar.xz

## entrypoint ##
COPY ./entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

## nodejs ##
COPY ./node /app/node

## nginx ##
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /app/nginx/logs
RUN mkdir -p /app/nginx/html
COPY ./nginx/index.html /app/nginx/html/index.html

EXPOSE 80

ENTRYPOINT ["/app/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
