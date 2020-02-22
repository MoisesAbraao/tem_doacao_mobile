import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:tem_doacao_mobile/repositories/donations_repository.dart';

import 'donations_event.dart';
import 'donations_state.dart';

class DonationsBloc extends Bloc<DonationsEvent, DonationsState> {
  final IDonationsRepository repository;

  DonationsBloc(this.repository);

  @override
  DonationsState get initialState => DonationsLoading();

  @override
  Stream<DonationsState> mapEventToState(DonationsEvent event) async* {
    if (event is Load) {
      yield DonationsLoading();

      final paginatedDonations = await repository.getRecents();

      yield paginatedDonations.fold(
        (failure) => DonationsLoaded(
          donations: BuiltList.from([]),
          nextCursor: '',
          loadingMore: false,
          errorMessage: failure.message,
        ),
        (paginatedDonations) => DonationsLoaded(
          donations: paginatedDonations.results,
          nextCursor: paginatedDonations.nextCursor,
          loadingMore: false,
          errorMessage: '',
        ),
      );
    } else if (event is LoadMore) {
      yield (state as DonationsLoaded).copyWith(loadingMore: true, errorMessage: '');

      final paginatedDonations = await repository.getByCursor(event.cursor);

      yield paginatedDonations.fold(
        (failure) => (state as DonationsLoaded)
          .copyWith(loadingMore: false, errorMessage: failure.message),
        (paginatedDonations) => (state as DonationsLoaded)
          .copyWith(
            donations: (state as DonationsLoaded).donations
              .rebuild((updates) => updates.addAll(paginatedDonations.results)),
            nextCursor: paginatedDonations.nextCursor,
            loadingMore: false,
            errorMessage: '',
          )
      );
    }
  }
}
