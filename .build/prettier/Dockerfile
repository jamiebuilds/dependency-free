FROM node:12.1.0-stretch
COPY .build/prettier/package.json .
COPY .build/prettier/package-lock.json .
RUN npm ci
WORKDIR /workdir
ENTRYPOINT [ "/node_modules/.bin/prettier" ]
CMD [ "--write", "**" ]
