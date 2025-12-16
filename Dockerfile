FROM registry.k8s.io/git-sync/git-sync:v4.5.0 AS git-sync

FROM traefik:v3.0

COPY --from=git-sync /git-sync /usr/local/bin/git-sync
COPY bin/ /usr/local/bin/

ENV ENABLE_GITSYNC=0
ENV GITSYNC_VERBOSE=0
ENV GITSYNC_REF=HEAD
ENV GITSYNC_ROOT=/git
ENV GITSYNC_PERIOD=30s
ENV GITSYNC_EXECHOOK_COMMAND=/usr/local/bin/gateway-hook-configsync
ENV GITSYNC_MAX_FAILURES=1000000

ENV GATEWAY_CONFIG_PATH=envs/staging
ENV GITSYNC_REPO=https://github.com/ardikabs/traefik-gateway
# ENV GITSYNC_USERNAME=ghp_GITHUB_PERSONAL_ACCESS_TOKEN
# ENV GITSYNC_PASSWORD=x-oauth-basic

RUN apk add --no-cache bash git curl rsync

ENTRYPOINT [ "gateway" ]