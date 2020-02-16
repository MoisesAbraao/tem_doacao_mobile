import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {}

class SignInUp extends AuthEvent {}

class SignOut extends AuthEvent {}
