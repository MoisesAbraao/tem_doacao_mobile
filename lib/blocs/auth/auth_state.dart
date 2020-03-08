import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/token_user.dart';

@immutable
abstract class AuthState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthState {}

class Authenticating extends AuthState {}

class Authenticated extends AuthState {
  final TokenUser tokenUser;

  Authenticated({this.tokenUser});

  @override
  List<Object> get props => [tokenUser];
}

class AuthenticationFail extends AuthState {
  final String message;

  AuthenticationFail({this.message});

  @override
  List<Object> get props => [message];
}
