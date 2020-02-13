import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/category.dart';

@immutable
abstract class CategoriesState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final BuiltList<Category> categories;

  CategoriesLoaded({this.categories});

  @override
  List<Object> get props => [
    categories,
  ];
}

class CategoriesLoadFail extends CategoriesState {
  final String message;

  CategoriesLoadFail({this.message});

  @override
  List<Object> get props => [
    message,
  ];
}
