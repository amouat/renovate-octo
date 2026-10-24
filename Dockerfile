FROM cgr.dev/chainguard/go:latest-dev@sha256:6935d7096121c0a0ce4c26192c40bc7ed4ae9076d2567e6d46d6c32817934aff

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:c12f0107f8afb0bbc1b0eff96ff8675e85a10c6083d039b777c51fef5c27420f
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
