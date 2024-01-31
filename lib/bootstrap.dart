import 'dart:async';

import 'package:boilerplate/features/app/view/app.dart';
import 'package:boilerplate/injector/injector.dart';
import 'package:boilerplate/services/crashlytics_service/crashlytics_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> bootstrap({
  AsyncCallback? firebaseInitialization,
  AsyncCallback? flavorConfiguration,
}) async {
  await runZonedGuarded(() async {
    final WidgetsBinding widgetsBinding =
        WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    final talker = TalkerFlutter.init(
      settings: TalkerSettings(
        colors: {
          TalkerLogType.verbose: AnsiPen()..yellow(),
        },
      ),
    );
    await firebaseInitialization?.call();
    talker.verbose('Talker initialization completed');

    await flavorConfiguration?.call();

    Injector.init();

    await Injector.instance.allReady();

    Bloc.observer = TalkerBlocObserver(
      talker: talker,
    );

    runApp(const App());
  }, (error, stack) {
    Injector.instance<CrashlyticsService>().recordException(error, stack);
  });
}
