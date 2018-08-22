FROM node:8-slim
RUN useradd -ms /bin/bash ghost-admin
RUN set -x \
        && npm i -g ghost-cli@latest \
        && mkdir -p /var/www/ghost \
        && chown -R ghost-admin /var/www/ghost

WORKDIR /var/www/ghost

USER ghost-admin
ARG VERSION
RUN ghost install --version=$VERSION --db=sqlite3 --no-setup --no-stack

EXPOSE 2368
WORKDIR /var/www/ghost/current

ENV server__host=0.0.0.0
ENV server__port=2368

ENTRYPOINT ["node", "index.js"]
