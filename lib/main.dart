import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:receptico/core/FirebaseAuthService/FirebaseAuthManager.dart';
import 'package:receptico/core/FirebaseUserService/FirebaseUserManager.dart';
import 'package:receptico/core/router/router.dart';
import 'package:receptico/features/auth/service/auth_email_service.dart';
import 'package:receptico/features/auth/service/auth_google_service.dart';
import 'package:receptico/features/profile/bloc/profile/profile_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import 'package:receptico/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/auth/bloc/auth_bloc.dart';
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

    final authorization = FirebaseAuthService(talker);
    final routerGuard = RouterGuard(authorization);
    final authEmail = AuthEmailService();
    final authGoogle = AuthGoogleService();
    final authBloc = AuthBloc(
      authEmailService: authEmail,
      authGoogleService: authGoogle,
    );
    final profileBloc = ProfileBloc(FirebaseUserService());

    GetIt.I.registerSingleton<FirebaseAuthManager>(authorization);
    GetIt.I.registerSingleton<IAuthEmailService>(authEmail);
    GetIt.I.registerSingleton<IAuthGoogleService>(authGoogle);
    GetIt.I.registerSingleton(authBloc);
    GetIt.I.registerSingleton(routerGuard);
    GetIt.I.registerSingleton(profileBloc);

    runApp(const App());
  }, (e, st) {
    GetIt.I<Talker>().handle(e, st);
  });
}
