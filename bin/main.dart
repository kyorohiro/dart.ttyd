import 'dart:io' as io;

Map<String, String> content_types = {
  "html": "text/html",
  "htm": "text/html",
  "css": "text/css",
  "js": "text/javascript"
};

main(List<String> args) async {
  print("Hello,World!");
  io.HttpServer server = await io.HttpServer.bind("0.0.0.0", 8080);
  server.listen((io.HttpRequest req) async {
    try {
      String path = req.uri.path;
      if (path == "/") {
        path = "/index.html";
      }
      String body = await loadResource(path);
      req.response
        ..headers.add(io.HttpHeaders.contentTypeHeader, await getContentTypeFromPath(path))
        ..write(body)
        ..write(req.uri.path)
        ..close();
    } catch (e) {
      req.response
        ..headers.add(io.HttpHeaders.contentTypeHeader, "text/*")
        ..write(e)
        ..write(req.uri.path)
        ..close();
    }
  });
}

Future<String> getContentTypeFromPath(String name) async {
  String ext = "";
  ext = name.split(new RegExp("[./]")).last;
  if(content_types.containsKey(ext)) {
    return content_types[ext];
  } else {
    return "*/*";
  }
}

Future<String> loadResource(String path) async {
  io.File file = new io.File("./res" + path);
  return await file.readAsString();
}
