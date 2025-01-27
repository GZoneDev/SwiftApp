import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:receptico/core/UI/theme/theme_adapter.dart';
import 'package:receptico/core/UI/theme/theme_provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:receptico/app.dart';
import 'package:receptico/core/authorization/authorization.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/features/auth/bloc/bloc.dart';
import 'package:receptico/features/auth/service/auth_email_service.dart';
import 'package:receptico/features/auth/service/auth_google_service.dart';
import 'package:receptico/features/profile/bloc/profile_bloc.dart';

import 'features/auth/service/implement/implement.dart';
import 'firebase_options.dart';

Future<void> main() async {
  const settingsBoxName = 'settingsBox';
  final talker = TalkerFlutter.init();

  GetIt.I.registerSingleton(talker);

  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(),
    ),
  );

  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(),
  );

  FlutterError.onError =
      (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Hive.initFlutter();
    Hive.registerAdapter(EThemeAdapter());

    final settingsBox = await Hive.openBox(settingsBoxName);
    final googleSingIn = GoogleSignIn();
    final passwordRestoreTimerService = TimerServiceImpl();
    final registerTimerService = TimerServiceImpl();
    final authorization = Authorization(talker);
    final routerGuard = RouterGuard(authorization);
    final authEmail = AuthEmailServiceFirebaseImpl(
      auth: FirebaseAuth.instance,
      loger: talker,
    );
    final authGoogle = AuthGoogleServiceFirebaseImpl(
      auth: FirebaseAuth.instance,
      googleSignIn: googleSingIn,
      loger: talker,
    );
    final authBloc = AuthBloc(
      authEmailService: authEmail,
      authGoogleService: authGoogle,
      restoreTimer: passwordRestoreTimerService,
      registerTimer: registerTimerService,
      loger: talker,
    );
    final timerBloc = TimerBloc(
      restoreTimer: passwordRestoreTimerService,
      registerTimer: registerTimerService,
      loger: talker,
    );
    final profileBlock = ProfileBloc();

    final themeProvider = ThemeProvider(settingBox: settingsBox);

    GetIt.I.registerSingleton(themeProvider);
    GetIt.I.registerSingleton<IAuthorization>(authorization);
    GetIt.I.registerSingleton<AuthEmailService>(authEmail);
    GetIt.I.registerSingleton<AuthGoogleService>(authGoogle);
    GetIt.I.registerSingleton(routerGuard);
    GetIt.I.registerSingleton(authBloc);
    GetIt.I.registerSingleton(timerBloc);
    GetIt.I.registerSingleton(profileBlock);

    runApp(const App());
  }, (e, st) {
    GetIt.I<Talker>().handle(e, st);
  });
}
