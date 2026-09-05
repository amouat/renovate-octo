FROM cgr.dev/chainguard/go:latest-dev@sha256:6a82137c1d344bf3f3b65d933016bbb09c0256a27a2937929d821ce0f9045b28

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:f51c2493951313c3ad4069080b2814ffb6ed6fe3909dabeb84a9482f42d5600b
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
