FROM node:16.8.0-alpine AS base
WORKDIR /app
COPY package.json package.json
COPY yarn.lock yarn.lock

FROM base AS copy-sources
WORKDIR /app
COPY tsconfig.json tsconfig.json
COPY src/ src/

FROM copy-sources as test
WORKDIR /app
RUN yarn

COPY test/ ./test
RUN npx tsc

CMD ["npx", "jest", "dist"]

FROM node:16.8.0-alpine AS final
WORKDIR /app
ENV NODE_ENV=production

RUN yarn --production=true
COPY --from=copy-sources /app/package.json /app/yarn.lock ./

CMD [ "yarn", "docker:start" ]