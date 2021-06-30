#! /bin/sh

case $1 in
  "build")
    [ -d "/path/to/dir" ] && [ ! -L "/path/to/dir" ] || mkdir -p builds
    cd ./src
    go build -gcflags="all=-N -l" -o main
    cd ..
    mv ./src/main ./builds/
  ;;
  "debug")
    dlv --listen=0.0.0.0:2345 --check-go-version=false --headless=true --api-version=2 --accept-multiclient exec ./builds/main
  ;;
esac