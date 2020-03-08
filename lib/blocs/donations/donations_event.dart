import 'package:meta/meta.dart';

@immutable
abstract class DonationsEvent {}

class DonationsLoad extends DonationsEvent {}

class DonationsLoadMore extends DonationsEvent {
  final String cursor;

  DonationsLoadMore({@required this.cursor});
}
