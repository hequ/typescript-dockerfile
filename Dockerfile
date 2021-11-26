FROM node:16.8-alpine AS base
WORKDIR /app
COPY package.json package.json
COPY yarn.lock yarn.lock
RUN yarn

FROM base AS deps
WORKDIR /app
COPY tsconfig.json tsconfig.json
COPY src/ src/
RUN yarn install --production

FROM base AS build
WORKDIR /app
COPY tsconfig.json tsconfig.json
COPY src/ src/
RUN yarn tsc

FROM node:16.8-alpine AS combine
WORKDIR /app
COPY --from=build /app ./
RUN rm -rf /app/node_modules
COPY --from=deps /app ./

FROM node:16.8-alpine AS final
WORKDIR /app
COPY --from=combine /app ./
ENV NODE_ENV=production
CMD [ "yarn", "docker:start" ]

FROM build as test
WORKDIR /app
COPY test/ ./test
RUN yarn tsc
CMD ["npx", "jest", "dist"]