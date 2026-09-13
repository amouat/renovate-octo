FROM cgr.dev/chainguard/go:latest-dev@sha256:cded0bfd388aaab1c329f351938ca6ddb93bc23c8d25d86590db928e182b51de

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:bf639cba19ba56329e6907ac26a7afcdde57a80b6aa66d5100da6883196e6b82
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
