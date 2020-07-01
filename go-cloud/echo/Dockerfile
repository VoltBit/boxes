FROM golang:latest
# COPY . /app
WORKDIR /app
RUN go get -u github.com/labstack/echo/...
RUN go get github.com/githubnemo/CompileDaemon

ENTRYPOINT CompileDaemon --build="go build -o echo-server" --command="./echo-server"