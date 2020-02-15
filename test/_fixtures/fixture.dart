
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

String fixture(String name) {
   String _basePath = Directory.current.path;
   if (!_basePath.endsWith('/test'))
     _basePath = join(_basePath, 'test');

   return File(join(_basePath, '_fixtures', name)).readAsStringSync();
}

Map<String, dynamic> fixtureAsMap(String name) => jsonDecode(fixture(name));
