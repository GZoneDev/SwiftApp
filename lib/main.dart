import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:receptico/core/authorization/authorization.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/features/auth/bloc/bloc.dart';
import 'package:receptico/features/auth/service/auth_email_service.dart';
import 'package:receptico/features/auth/service/auth_google_service.dart';
import 'package:receptico/features/auth/service/timer_service.dart';
import 'package:receptico/features/profile/bloc/profile_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import 'package:receptico/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
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

    final passwordRestoreTimerService = TimerService();
    final registerTimerService = TimerService();
    final authorization = Authorization(talker);
    final routerGuard = RouterGuard(authorization);
    final authEmail = AuthEmailService();
    final authGoogle = AuthGoogleService();
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

    GetIt.I.registerSingleton<IAuthorization>(authorization);
    GetIt.I.registerSingleton<IAuthEmail>(authEmail);
    GetIt.I.registerSingleton<IAuthGoogle>(authGoogle);
    GetIt.I.registerSingleton(routerGuard);
    GetIt.I.registerSingleton(authBloc);
    GetIt.I.registerSingleton(timerBloc);
    GetIt.I.registerSingleton(profileBlock);

    runApp(const App());
  }, (e, st) {
    GetIt.I<Talker>().handle(e, st);
  });
}
