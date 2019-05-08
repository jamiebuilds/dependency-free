FROM node:12.1.0-stretch
COPY .build/typescript/package.json .
COPY .build/typescript/package-lock.json .
RUN npm ci
COPY .build/typescript/script.sh .
RUN chmod +x ./script.sh
WORKDIR /workdir
ENTRYPOINT [ "/script.sh" ]
CMD [ "--noEmit" ]
