FROM cgr.dev/chainguard/go:latest-dev@sha256:7956385d08d0eff6a540fcb837963bb9dfc94ca5774c4d3edbd2c0983d234277

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:fc42af33e643f20d08baf03cddcc1c02ba57052dfb02edb0d79f3fc47bcea8d9
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
