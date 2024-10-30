enum RequestMethod {
  get,
  post,
}

class Request {
  final RequestMethod method;
  final String route;
  final dynamic params;
  Request(this.route, this.method, this.params);
}
