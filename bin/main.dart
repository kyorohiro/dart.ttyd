import 'dart:io' as io;

main(List<String> args) async {
  print("Hello,World!");
  io.HttpServer server = await io.HttpServer.bind("0.0.0.0", 8080);
  server.listen((io.HttpRequest req) {
    req.response
      ..write("Hello,World!!")
      ..close();
  });
}