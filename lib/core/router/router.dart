import 'package:auto_route/auto_route.dart';
import 'package:receptico/core/authorization/authorization.dart';
import 'package:receptico/features/auth/auth.dart';
import 'package:receptico/features/auth/router/auth_router.dart';
import 'package:receptico/features/auth/view/temp_logout_page.dart';

part 'router.gr.dart';

class RouterGuard extends AutoRouteGuard {
  final IAuthorization _auth;

  RouterGuard(this._auth);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_auth.isAuthorization) {
      resolver.next(true);
    } else {
      resolver.redirect(StartRoute());
    }
  }
}

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        ...authRouting,
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}
