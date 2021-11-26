FROM node:16.8-alpine AS base
WORKDIR /app
COPY package.json package.json
COPY yarn.lock yarn.lock
RUN yarn

# Install production dependencies only
FROM node:16.8-alpine AS deps
WORKDIR /app
COPY package.json package.json
COPY yarn.lock yarn.lock
RUN yarn install --production

# Compile typescript sources
FROM base AS build
WORKDIR /app
COPY tsconfig.json tsconfig.json
COPY src/ src/
COPY test/ test/
RUN yarn tsc

# Combine production only node_modules with compiled javascript files.
FROM node:16.8-alpine AS final
WORKDIR /app
COPY --from=deps /app/node_modules ./app/node_modules
COPY --from=build /app/dist/src ./dist/
COPY --from=build /app/package.json ./
CMD [ "yarn", "docker:start" ]

FROM build as test
WORKDIR /app
CMD ["npx", "jest", "dist"]