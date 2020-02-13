import 'package:meta/meta.dart';

@immutable
abstract class CategoriesEvent {}

class CategoriesLoad extends CategoriesEvent {}
