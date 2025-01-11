import 'package:auto_route/auto_route.dart';
import 'package:receptico/core/authorization/authorization.dart';
import 'package:receptico/features/auth/auth.dart';
import 'package:receptico/features/auth/view/temp_logout_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AuthGuard _authGuard;

  AppRouter(final IAuthorization auth) : _authGuard = AuthGuard(auth);

  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: StartRoute.page,
          path: '/',
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
        CustomRoute(
          page: SendEmailRoute.page,
          path: '/sendEmail',
          transitionsBuilder: TransitionsBuilders.slideRight,
          durationInMilliseconds: 500,
        ),
        CustomRoute(
          page: TempLogoutRoute.page,
          path: '/temp',
          guards: [_authGuard],
          transitionsBuilder: TransitionsBuilders.slideBottom,
          durationInMilliseconds: 500,
        ),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}

class AuthGuard extends AutoRouteGuard {
  final IAuthorization _auth;

  AuthGuard(this._auth);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_auth.isAuthorization) {
      resolver.next(true);
    } else {
      resolver.redirect(LoginRoute());
    }
  }
}
