FROM mhart/alpine-node:10
RUN addgroup -g 1001 -S app &&\
  adduser -u 1001 -S app -G app -h /app &&\
  npm i -g npm@latest
EXPOSE 4200
ENV HOME=/app
COPY package.json package-lock.json* $HOME/
RUN chown -R app:app $HOME
USER app
WORKDIR $HOME
RUN npm install --no-optional && npm cache clean --force
CMD npm start -- --host 0.0.0.0 --poll 500
