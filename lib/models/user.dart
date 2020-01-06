import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class User with EquatableMixin {
  final String id;
  final String name;
  final String photoUrl;

  ImageProvider get photo {
    if (photoUrl != null && photoUrl != '')
      return NetworkImage(photoUrl);
    // default image
    // image 1x1 with opacity 0
    // http://www.1x1px.me/
    // converted to base64
    // https://www.base64-image.de/
    return MemoryImage(base64Decode('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNiYAAAAAkAAxkR2eQAAAAASUVORK5CYII='));
  }

  User({
    @required this.id,
    @required this.name,
    @required this.photoUrl,
  });

  factory User.fromJson(Map<String, dynamic> data) =>
    User(
      id: data['id'],
      name: data['name'],
      photoUrl: data['photo_url'],
    );

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'name': name,
      'photo_url': photoUrl,
    };

  User copyWith({
    String id,
    String name,
    String photoUrl,
  }) =>
    User(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
    );

  @override
  List<Object> get props => [
    id,
    name,
    photoUrl,
  ];

  @override
  String toString() =>
    '$runtimeType { '
    '"id": "$id", '
    '"name": "$name", '
    '"photoUrl": "$photoUrl", '
    '}';
}
