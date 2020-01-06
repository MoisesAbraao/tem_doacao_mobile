import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class DonationImage with EquatableMixin {
  final String id;
  final String imageUrl;

  ImageProvider get image {
    if (imageUrl != null && imageUrl != '')
      return NetworkImage(imageUrl);
    // default image
    // base64 from image 1x1 with opacity 0
    // http://www.1x1px.me/
    // converted to base64
    // https://www.base64-image.de/
    return MemoryImage(base64Decode('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNiYAAAAAkAAxkR2eQAAAAASUVORK5CYII='));
  }

  DonationImage({
    @required this.id,
    @required this.imageUrl,
  });

  factory DonationImage.fromJson(Map<String, dynamic> data) =>
    DonationImage(
      id: data['id'] as String,
      imageUrl: data['image_url'] as String,
    );

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'image_url': imageUrl,
    };

  DonationImage copyWith({
    String id,
    String imageUrl,
  }) =>
    DonationImage(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
    );

  @override
  List<Object> get props => [
    id,
    imageUrl,
  ];

  @override
  String toString() =>
    '$runtimeType { '
    '"id": "$id", '
    '"description": "$imageUrl", '
    '}';
}
