FROM cgr.dev/chainguard/go:latest-dev

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
