FROM cgr.dev/chainguard/go:latest-dev@sha256:2c32cf4edc1a6c4888501693c6e88e5e979c6137715368331d1a59a7b3a15733

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:8658e9eaeb2294fa0e49b0667f7d66b4e21fa7690b8d2a4c30cd1d013ceb9eb7
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
