import http from "http";

const server = http.createServer();

server.addListener("request", (req, res) => {
  res.writeHead(200);
  res.end("Hello world");
});

server.listen(process.env.PORT || 3000, () => {
  console.log(`Started server on port ${process.env.PORT || 3000}`);
});
