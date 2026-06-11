FROM alpine:3.19
RUN apk add --no-cache ca-certificates wget
ARG GATUS_VERSION=v5.24.1
RUN wget -qO /tmp/gatus.tar.gz "https://github.com/TwiN/gatus/releases/download/${GATUS_VERSION}/gatus_${GATUS_VERSION}_linux_amd64.tar.gz" && tar -xzf /tmp/gatus.tar.gz -C /usr/local/bin/ gatus && rm /tmp/gatus.tar.gz
COPY config.yaml /config/config.yaml
ENV GATUS_CONFIG_PATH=/config/config.yaml
ENV PORT=8080
EXPOSE 8080
CMD ["gatus"]
