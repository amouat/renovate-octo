FROM cgr.dev/chainguard/go:latest-dev@sha256:4a480724a43d7c7bf31a0b0299d3e1e3ee0e3e739388a0a47c04a6836efba1b8

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:3348c5f7b97a4d63944034a8c6c43ad8bc69771b2564bed32ea3173bc96b4e04
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
