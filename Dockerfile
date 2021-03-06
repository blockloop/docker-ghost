ARG NODE_VERSION=lts
FROM node:$NODE_VERSION-slim
RUN useradd -ms /bin/bash ghost-admin
RUN set -x \
        && npm i -g ghost-cli@latest \
        && mkdir -p /var/www/ghost \
        && chown -R ghost-admin /var/www/ghost

EXPOSE 2368

USER ghost-admin
ARG VERSION

ENV server__host=0.0.0.0
ENV server__port=2368

WORKDIR /var/www/ghost

RUN ghost install --version=$VERSION --db=sqlite3 --no-setup --no-stack

ENTRYPOINT ["node", "current/index.js"]
