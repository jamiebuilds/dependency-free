FROM node:12.1.0-stretch
COPY .build/parcel/package.json .
COPY .build/parcel/package-lock.json .
RUN npm ci
COPY .build/parcel/script.sh .
RUN chmod +x ./script.sh
WORKDIR /workdir
ENTRYPOINT [ "/script.sh" ]
CMD [ "build", "src/index.html" ]
