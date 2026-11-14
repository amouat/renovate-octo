FROM cgr.dev/chainguard/go:latest-dev@sha256:5620619a63b7e4e5fd251516a01b63357803ed81a45ebf7d552b7727afe96e7c

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:fc42af33e643f20d08baf03cddcc1c02ba57052dfb02edb0d79f3fc47bcea8d9
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
