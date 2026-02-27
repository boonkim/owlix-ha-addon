# Official image is distroless (no shell/apk), so we use multi-stage:
# copy cloudflared binary into Alpine so we can run run.sh + jq
FROM cloudflare/cloudflared:latest AS cloudflared
FROM alpine:latest

RUN apk add --no-cache jq
COPY --from=cloudflared /usr/local/bin/cloudflared /usr/local/bin/cloudflared

COPY run.sh /run.sh
RUN chmod a+x /run.sh

ENTRYPOINT ["/run.sh"]
