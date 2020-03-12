import 'dart:convert' show jsonDecode;
import 'package:flutter/services.dart' show AssetBundle;

const String APP_CONFIG_FILENAME = 'app_config.json';

class AppConfig {
  Map<String, dynamic> _config;

  final AssetBundle assetBundle;

  AppConfig(this.assetBundle);

  Future<void> initialize() async =>
    _config = jsonDecode(await assetBundle.loadString(APP_CONFIG_FILENAME));

  String get apiBaseUrl => _config['api_base_url'];
}
