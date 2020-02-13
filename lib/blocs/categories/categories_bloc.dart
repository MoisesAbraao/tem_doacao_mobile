import 'package:bloc/bloc.dart';

import '../../repositories/categories_repository.dart';
import 'categories_event.dart';
import 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final CategoriesRepository repository;

  CategoriesBloc(this.repository);

  @override
  CategoriesState get initialState => CategoriesLoading();

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
    if (event is CategoriesLoad) {
      yield CategoriesLoading();

      final categories = await repository.getAll();

      yield categories.fold(
        (failure) => CategoriesLoadFail(message: failure.message),
        (categories) => CategoriesLoaded(categories: categories)
      );
    }
  }
}
