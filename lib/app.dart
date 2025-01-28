import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:receptico/core/UI/theme/themes/theme_light.dart';
import 'package:receptico/core/UI/theme/theme_provider.dart';
import 'package:receptico/core/bloc/bloc_route_interface.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/features/profile/bloc/profile/profile_bloc.dart';
import 'package:receptico/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:receptico/providers/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:provider/provider.dart';

import 'features/auth/bloc/bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appRouter = AppRouter();

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => GetIt.I<ThemeProvider>(),
          ),
          ChangeNotifierProvider<LocaleProvider>(
            create: (context) => GetIt.I<LocaleProvider>(),
          ),
        ],
        builder: (context, child) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          final localeProvider = Provider.of<LocaleProvider>(context);
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(create: (_) => GetIt.I<AuthBloc>()),
              BlocProvider<TimerBloc>(create: (_) => GetIt.I<TimerBloc>()),
              BlocProvider<ProfileBloc>(create: (_) => GetIt.I<ProfileBloc>()),
              // Add BLoC .....
            ],
            child: MaterialApp.router(
              routerConfig: _appRouter.config(
                navigatorObservers: () => [
                  TalkerRouteObserver(GetIt.I<Talker>()),
                  BlocRouteObserver(GetIt.I<AuthBloc>()),
                ],
              ),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: localeProvider.locale,
              supportedLocales: S.delegate.supportedLocales,
              title: 'Receptico',
              theme: themeProvider.currentTheme,
              builder: (context, child) {
                context.read<AuthBloc>().updateLocalization(S.of(context));
                return child!;
              },
            ),
          );
        },
      );
}
