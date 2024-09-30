FROM ubuntu:20.04
RUN apt-get update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata
RUN apt-get update \
    && apt-get install -y --allow-unauthenticated \
        curl \
        p7zip-full \
        nginx \
        supervisor

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && apt-get install -yq nodejs

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

COPY --chown=www:www . .

RUN mkdir -p /var/log/supervisor
RUN chown www:www /var/log/supervisor

# USER www

CMD ["/usr/bin/supervisord"]
