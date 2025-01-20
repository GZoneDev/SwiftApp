import 'package:auto_route/auto_route.dart';
import 'package:receptico/core/router/router.dart';

final List<AutoRoute> authRouting = [
  CustomRoute(
    page: StartRoute.page,
    path: '/start',
    transitionsBuilder: TransitionsBuilders.slideBottom,
    durationInMilliseconds: 500,
  ),
  CustomRoute(
    page: FailRoute.page,
    path: '/fail',
    transitionsBuilder: TransitionsBuilders.fadeIn,
    durationInMilliseconds: 500,
  ),
  CustomRoute(
    page: LoginRoute.page,
    path: '/login',
    transitionsBuilder: TransitionsBuilders.fadeIn,
    durationInMilliseconds: 500,
  ),
  CustomRoute(
    page: RegisterRoute.page,
    path: '/register',
    transitionsBuilder: TransitionsBuilders.zoomIn,
    durationInMilliseconds: 500,
  ),
  CustomRoute(
    page: RestorePasswordRoute.page,
    path: '/restorePasword',
    transitionsBuilder: TransitionsBuilders.slideLeft,
    durationInMilliseconds: 500,
  ),
];
