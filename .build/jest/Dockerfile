FROM node:12.1.0-stretch
COPY .build/jest/package.json .
COPY .build/jest/package-lock.json .
RUN npm ci
COPY .build/jest/script.sh .
RUN chmod +x ./script.sh
WORKDIR /workdir
ENTRYPOINT [ "/script.sh" ]
