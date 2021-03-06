FROM node:latest

# prepare a user which runs everything locally! - required in child images!
RUN useradd --user-group --create-home --shell /bin/false app

RUN npm install -g nodemon
RUN npm install -g @angular/cli

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY package.json /usr/src/app
RUN npm install
RUN npm rebuild grpc
COPY . /usr/src/app/
ENV GOOGLE_APPLICATION_CREDENTIALS /usr/src/app/reboting_gcloud.json
CMD ["npm","run","server:docker"]
EXPOSE 3000
