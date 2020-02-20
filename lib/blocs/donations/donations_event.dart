import 'package:meta/meta.dart';

@immutable
abstract class DonationsEvent {}

class Load extends DonationsEvent {}

class LoadMore extends DonationsEvent {
  final String cursor;

  LoadMore({
    this.cursor,
  });
}
