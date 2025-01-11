import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:receptico/core/UI/theme/theme_light.dart';
import 'package:receptico/core/authorization/authorization.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'features/auth/bloc/bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter(GetIt.I<IAuthorization>());

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => GetIt.I<AuthBloc>(),
          // Add BLoC .....
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(
          navigatorObservers: () => [TalkerRouteObserver(GetIt.I<Talker>())],
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: Locale('uk'),
        supportedLocales: S.delegate.supportedLocales,
        title: 'Flutter Demo',
        theme: lightTheme,
        builder: (context, child) {
          context.read<AuthBloc>().updateLocalization(S.of(context));
          return child!;
        },
      ),
    );
  }
}
