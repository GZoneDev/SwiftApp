import 'package:flutter/material.dart';

abstract interface class IBlocRoute {
  void routeEvent();
}

class BlocRouteObserver extends NavigatorObserver {
  final IBlocRoute bloc;
  BlocRouteObserver(this.bloc);

  @override
  void didPush(Route route, Route? previousRoute) => bloc.routeEvent();

  @override
  void didPop(Route route, Route? previousRoute) => bloc.routeEvent();
}
