import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

const String DEFAULT_FAILURE_MESSAGE = 'An error has occurred!';

@immutable
class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  factory Failure.from(dynamic f) {
    if (f is HttpException) {
      return Failure('Could not reach the server!');
    } else if (f is SocketException) {
      return Failure('Verify your internet connection!');
    } else if (f is FormatException) {
      return Failure('Could not do that operation!');
    }
    return Failure(DEFAULT_FAILURE_MESSAGE);
  }

  List<Object> get props => [message];

  @override
  String toString() => '$runtimeType { "message": "$message" }';
}
