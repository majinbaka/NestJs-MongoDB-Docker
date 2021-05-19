FROM node:14

# Set working directory
RUN mkdir -p /var/www/nest-mongo
WORKDIR /var/www/nest-mongo

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /var/www/nest-mongo/node_modules/.bin:$PATH
# create user with no password
RUN adduser --disabled-password demo

# Copy existing application directory contents
COPY . /var/www/nest-mongo
# install and cache app dependencies
COPY package.json /var/www/nest-mongo/package.json
COPY package-lock.json /var/www/nest-mongo/package-lock.json

# grant a permission to the application
RUN chown -R demo:demo /var/www/nest-mongo
USER demo

# clear application caching
RUN npm cache clean --force
# install all dependencies
RUN npm install

EXPOSE 3000
# start run in production environment
#CMD [ "npm", "run", "pm2:delete" ]
#CMD [ "npm", "run", "build-docker:dev" ]

# start run in development environment
CMD [ "npm", "run", "start:dev" ]