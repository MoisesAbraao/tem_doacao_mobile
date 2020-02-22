import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/donation.dart';

@immutable
abstract class DonationsState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class DonationsLoading extends DonationsState {}

class DonationsLoaded extends DonationsState {
  final BuiltList<Donation> donations;
  final String nextCursor;
  final bool loadingMore;
  final String errorMessage;

  DonationsLoaded({
    @required this.donations,
    @required this.nextCursor,
    @required this.loadingMore,
    @required this.errorMessage,
  });

  DonationsLoaded copyWith({
    BuiltList<Donation> donations,
    String nextCursor,
    bool loadingMore,
    String errorMessage,
  }) =>
    DonationsLoaded(
      donations: donations ?? this.donations,
      nextCursor: nextCursor ?? this.nextCursor,
      loadingMore: loadingMore ?? this.loadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );

  @override
  List<Object> get props => [
    donations,
    nextCursor,
    loadingMore,
    errorMessage,
  ];
}
