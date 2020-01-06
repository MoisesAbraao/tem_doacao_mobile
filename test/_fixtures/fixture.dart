
import 'dart:convert';
import 'dart:io';

String fixture(String path) => File(path).readAsStringSync();

Map<String, dynamic> fixtureAsMap(String path) => jsonDecode(fixture(path));
