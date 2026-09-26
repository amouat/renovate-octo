FROM cgr.dev/chainguard/go:latest-dev@sha256:11b08ed26e99379f8df32197348c1a16093b15a071bbd2793125040982f46f91

WORKDIR /work

COPY go.mod /work/
COPY cmd /work/cmd
COPY internal /work/internal

RUN CGO_ENABLED=0 go build -o hello ./cmd/server

FROM cgr.dev/chainguard/static:latest@sha256:41e17ed83c594a64a9396b6ab96dd26d5ddc290dacf4c177464712ff21ad534f
COPY --from=builder /work/hello /hello

ENTRYPOINT ["/hello"]
