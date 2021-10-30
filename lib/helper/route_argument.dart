class RouteArgument {
  dynamic param;

  RouteArgument({this.param});

  @override
  String toString() {
    return '{iparam:${param}}';
  }
}
