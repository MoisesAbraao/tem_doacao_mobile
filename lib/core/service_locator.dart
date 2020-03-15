import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/categories/categories_bloc.dart';
import '../blocs/donations/donations_bloc.dart';
import '../repositories/auth_repository.dart';
import '../repositories/categories_repository.dart';
import '../repositories/donations_repository.dart';
import '../repositories/social_auth_repository.dart';
import 'app_config.dart';

final GetIt locator = GetIt.instance;

Future<void> initializeServiceLocator() async {
  // app config
  final appConfig = AppConfig(rootBundle);
  await appConfig.initialize();
  locator.registerSingleton(appConfig);

  // http client
  locator.registerLazySingleton(() =>
    dio.Dio(
      dio.BaseOptions(
        baseUrl: locator<AppConfig>().apiBaseUrl,
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType
        },
      ),
    ),
  );

  // repositories
  locator.registerFactory<IAuthRepository>(() => AuthRepository(locator()));
  locator.registerFactory<ICategoriesRepository>(() => CategoriesRepository(locator()));
  locator.registerFactory<IDonationsRepository>(() => DonationsRepository(locator()));
  locator.registerFactory<ISocialAuthRepository>(() => SocialAuthRepository(locator()));

  // blocs
  locator.registerLazySingleton(() => AuthBloc(locator(), locator()));
  locator.registerLazySingleton(() => CategoriesBloc(locator()));
  locator.registerLazySingleton(() => DonationsBloc(locator()));

  // others
  locator.registerSingleton<GoogleSignIn>(GoogleSignIn());
}
