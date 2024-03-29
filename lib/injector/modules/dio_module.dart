import 'package:boilerplate/configs/app_config.dart';
import 'package:boilerplate/injector/injector.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class DioModule {
  DioModule._();

  static const String dioInstanceName = 'dioInstance';
  static final GetIt _injector = Injector.instance;

  static void setup() {
    _setupDio();
  }

  static void _setupDio() {
    /// Dio
    _injector.registerLazySingleton<Dio>(
      () {
        // TODO(boilerplate): custom DIO here
        final Dio dio = Dio(
          BaseOptions(
            baseUrl: AppConfig.baseUrl,
          ),
        );
        if (!kReleaseMode) {
          dio.interceptors.add(
            TalkerDioLogger(
              settings: const TalkerDioLoggerSettings(
             printRequestData: false,
             printResponseHeaders: true,
              ),
            ),
          );
        }
        return dio;
      },
      instanceName: dioInstanceName,
    );
  }
}
