FROM cgr.dev/chainguard/go:latest-dev@sha256:ee4bc4294d5339b1f8a6a53c74f22ffb388b683b82ef439039b11bde039a4992

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:7bdd9720cefba78e8133c4d03eaaf3f18a25d147d2c8803cc830061e46b6b474
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
