FROM twinproduction/gatus:latest AS gatus
FROM alpine:3.19 AS prep
COPY config.yaml /config.yaml
FROM scratch
COPY --from=gatus /gatus /
COPY --from=gatus /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=prep /config.yaml /config/config.yaml
ENV GATUS_CONFIG_PATH=/config/config.yaml
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["/gatus"]