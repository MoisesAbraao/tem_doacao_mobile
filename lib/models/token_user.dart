import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'user.dart';

@immutable
class TokenUser with EquatableMixin {
  final String token;
  final User user;

  TokenUser({
    this.token,
    this.user,
  });

  factory TokenUser.fromJson(Map data) =>
    TokenUser(
      token: data['token'] as String,
      user: User.fromJson(data['user'] as Map),
    );

  Map<String, dynamic> toJson() =>
    {
      'token': token,
      'user': user.toJson(),
    };

  TokenUser copyWith({
    String token,
    User user,
  }) =>
    TokenUser(
      token: token ?? this.token,
      user: user ?? this.user,
    );

  @override
  List<Object> get props =>
    [
      token,
      user,
    ];

  @override
  String toString() =>
    '$runtimeType { '
    'token: $token, '
    'user: $user, '
    '}';
}
