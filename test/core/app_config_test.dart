import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show AssetBundle;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tem_doacao_mobile/core/app_config.dart';

import '../_fixtures/fixture.dart';

class MockAssetBundle extends Mock implements AssetBundle {}

void main() {
  AssetBundle assetBundle;
  AppConfig appConfig;
  final String appConfigFilenameFixture = 'app_config.json';

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    assetBundle = MockAssetBundle();
    appConfig = AppConfig(assetBundle);
  });

  test('should load configurations from right file', () async {
    when(assetBundle.loadString(APP_CONFIG_FILENAME))
        .thenAnswer((_) async => fixture(appConfigFilenameFixture));

    await appConfig.initialize();

    verify(assetBundle.loadString(APP_CONFIG_FILENAME));
  });

  group('should bind right key from json file loaded', () {
    test('for apiBaseUrl', () async {
      when(assetBundle.loadString(APP_CONFIG_FILENAME))
        .thenAnswer((_) async => fixture(appConfigFilenameFixture));

      await appConfig.initialize();

      final tAppConfigMap = fixtureAsMap(appConfigFilenameFixture);

      expect(appConfig.apiBaseUrl, tAppConfigMap['api_base_url']);
    });
  });
}
