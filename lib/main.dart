import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:receptico/app.dart';
import 'package:receptico/core/authorization/authorization.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/features/auth/bloc/bloc.dart';
import 'package:receptico/features/profile/bloc/profile_bloc.dart';

import 'features/auth/service/implement/implement.dart';
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

  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
    final googleSingIn = GoogleSignIn();
    final authorization = Authorization(talker);
    final routerGuard = RouterGuard(authorization);
    final authEmail = AuthEmailServiceFirebaseImpl(
      auth: FirebaseAuth.instance,
      loger: talker,
    );
    final authValidationService = AuthValidationServiceImpl();
    final authGoogle = AuthGoogleServiceFirebaseImpl(
      auth: FirebaseAuth.instance,
      googleSignIn: googleSingIn,
      loger: talker,
    );
    final passwordRestoreTimerService = TimerServiceImpl();
    final registerTimerService = TimerServiceImpl();

    final authBloc = AuthBloc(
      validationService: authValidationService,
      authEmailService: authEmail,
      authGoogleService: authGoogle,
      restoreTimer: passwordRestoreTimerService,
      registerTimer: registerTimerService,
      loger: GetIt.I<Talker>(),
    );

    final timerBloc = TimerBloc(
      restoreTimer: passwordRestoreTimerService,
      registerTimer: registerTimerService,
      loger: GetIt.I<Talker>(),
    );

    final profileBloc = ProfileBloc();

    GetIt.I.registerSingleton(routeObserver);
    GetIt.I.registerSingleton<IAuthorization>(authorization);
    GetIt.I.registerSingleton(routerGuard);
    GetIt.I.registerSingleton(authBloc);
    GetIt.I.registerSingleton(timerBloc);
    GetIt.I.registerSingleton(profileBloc);

    runApp(const App());
  }, (e, st) {
    GetIt.I<Talker>().handle(e, st);
  });
}
