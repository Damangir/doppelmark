FROM golang:1.16 as doppelmark
# doppelmark is only supported with the old go1.13, so we build it separately.
WORKDIR /go/src/doppelmark
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 go build -o /go/bin/doppelmark

FROM gcr.io/distroless/static-debian11

COPY --from=doppelmark /go/bin/doppelmark /
ENTRYPOINT ["/doppelmark"]
