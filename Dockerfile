FROM golang:1.17-alpine AS base

ARG BUILD_DEPS="build-base git make"
ARG RUNTIME_DEPS="bash curl jq"
ARG UID="50000"

ENV APP_DIR="/app"
WORKDIR $APP_DIR

RUN apk add --no-cache $BUILD_DEPS $RUNTIME_DEPS \
    && rm -rf /var/cache/apk/* \
    && addgroup --gid $UID appuser \
    && adduser --disabled-password --system --uid $UID --ingroup appuser appuser


FROM base AS celestia-app

RUN git clone --depth=1 --single-branch https://github.com/celestiaorg/celestia-app.git \
    && make --directory celestia-app install \
    && rm -rf celestia-app \
    && go clean --cache \
    && apk del $BUILD_DEPS \
    && mkdir -p /home/appuser/.celestia-app/data \
    && chown --recursive appuser:appuser /home/appuser/

USER appuser

ENTRYPOINT ["celestia-appd"]


FROM base AS celestia-node

ARG CELESTIA_NODE_GIT_TAG

RUN git clone --depth=1 --single-branch --branch $CELESTIA_NODE_GIT_TAG https://github.com/celestiaorg/celestia-node.git \
    && make --directory celestia-node install \
    && rm -rf celestia-node \
    && go clean --cache \
    && apk del $BUILD_DEPS \
    && mkdir -p /home/appuser/.celestia-full/data \
    && chown --recursive appuser:appuser /home/appuser/

USER appuser

ENTRYPOINT ["celestia"]
