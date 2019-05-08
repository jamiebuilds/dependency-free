FROM node:12.1.0-stretch
COPY .build/eslint/package.json .
COPY .build/eslint/package-lock.json .
RUN npm ci
WORKDIR /workdir
ENTRYPOINT [ "/node_modules/.bin/eslint", "--ext=ts,tsx", "--cache" ]
CMD [ "." ]
