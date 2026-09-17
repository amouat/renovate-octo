FROM cgr.dev/chainguard/go:latest-dev@sha256:ceb74f4cdb7a5673f522e5b8b00af3f713b8446a4ce0c9c818d2e8fbeef448f5

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:bf639cba19ba56329e6907ac26a7afcdde57a80b6aa66d5100da6883196e6b82
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
