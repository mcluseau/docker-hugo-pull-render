from golang:1.11.2-alpine

from alpine:3.8

volume "/git"
volume "/output"

run apk add --update git
copy --from build /go/bin/* /bin/*

entrypoint ["/entrypoint.sh"]
add entrypoint.sh /

