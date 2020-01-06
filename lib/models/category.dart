import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Category with EquatableMixin {
  final String id;
  final String name;

  Category({
    @required this.id,
    @required this.name,
  });

  factory Category.fromJson(Map data) =>
    Category(
      id: data['id'] as String,
      name: data['name'] as String,
    );

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'name': name,
    };

  Category copyWith({
    String id,
    String name,
  }) =>
    Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );

  @override
  List<Object> get props => [
    id,
    name,
  ];

  @override
  String toString() =>
    '$runtimeType { '
    '"id": "$id", '
    '"name": "$name", '
    '}';
}
