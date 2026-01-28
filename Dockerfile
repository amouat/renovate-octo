FROM cgr.dev/chainguard/go:latest-dev@sha256:f5e0ab5fbb233ffc5f833f94821f2573df9ec81ddc5a767e19ecfe0e1a81c8e3

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:99a5f826e71115aef9f63368120a6aa518323e052297718e9bf084fb84def93c
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
