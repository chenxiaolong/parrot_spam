FROM clux/muslrust:1.40.0-stable

RUN curl -L -sS --fail -o /tmp/dumb-init \
    https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 \
    && chmod +x /tmp/dumb-init

COPY Cargo.* /tmp/
COPY src /tmp/src
RUN cd /tmp && cargo build --release
RUN strip /tmp/target/x86_64-unknown-linux-musl/release/PSaaS

# Release image
FROM scratch
COPY --from=0 \
    /tmp/dumb-init \
    /tmp/target/x86_64-unknown-linux-musl/release/PSaaS \
    /
EXPOSE 3030
ENTRYPOINT ["/dumb-init", "/PSaaS"]
