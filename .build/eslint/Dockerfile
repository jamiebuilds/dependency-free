FROM node:12.1.0-stretch
COPY .build/eslint/package.json .
COPY .build/eslint/package-lock.json .
RUN npm ci
COPY .build/eslint/script.sh .
RUN chmod +x ./script.sh
WORKDIR /workdir
ENTRYPOINT [ "/script.sh" ]
CMD [ "." ]
