FROM node:17-alpine AS base
USER node
WORKDIR /app
COPY --chown=node:node package.json package.json
COPY --chown=node:node yarn.lock yarn.lock
RUN yarn

# Install production dependencies only
FROM node:17-alpine AS deps
USER node
WORKDIR /app
COPY --chown=node:node package.json package.json
COPY --chown=node:node yarn.lock yarn.lock
RUN yarn install --production --frozen-lockfile

# Compile typescript sources
FROM base AS build
USER node
WORKDIR /app
COPY --chown=node:node tsconfig.json tsconfig.json
COPY --chown=node:node src/ src/
COPY --chown=node:node test/ test/
RUN yarn tsc

# Combine production only node_modules with compiled javascript files.
FROM node:17-alpine AS final
USER node
WORKDIR /app
COPY --chown=node:node --from=deps /app/node_modules ./app/node_modules
COPY --chown=node:node --from=build /app/dist/src ./dist/
COPY --chown=node:node --from=build /app/package.json ./
CMD [ "yarn", "docker:start" ]

FROM build as test
USER node
WORKDIR /app
CMD ["npx", "jest", "dist"]