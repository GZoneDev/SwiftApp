import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:receptico/features/auth/auth.dart';

import 'package:receptico/features/auth/view/temp_logout_page.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AuthGuard authGuard = AuthGuard();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: StartRoute.page, path: '/'),
        AutoRoute(page: FailRoute.page, path: '/fail'),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(page: RestorePasswordRoute.page, path: '/restorePasword'),
        AutoRoute(page: SendEmailRoute.page, path: '/sendEmail'),
        AutoRoute(
          page: TempLogoutRoute.page,
          path: '/temp',
          guards: [authGuard],
        ),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    /// TODO: fix this authentication method
    final authenticated = FirebaseAuth.instance.currentUser != null;
    if (authenticated) {
      resolver.next(true);
    } else {
      resolver.redirect(LoginRoute());
    }
  }
}
