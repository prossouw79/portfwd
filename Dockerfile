FROM --platform=linux/amd64 golang:bullseye as builder

RUN apt-get update \
    && apt-get install -y \
    build-essential \
    make \
    && apt-get clean

WORKDIR /build

COPY . .

RUN make

FROM ubuntu:focal as runtime

WORKDIR /app

COPY --from=builder /build/portfwd /app/portfwd

CMD /app/portfwd