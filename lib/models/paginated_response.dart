import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class PaginatedResponse<M extends dynamic> with EquatableMixin {
  final String prev;
  final String next;
  final BuiltList<M> results;

  PaginatedResponse({
    @required this.prev,
    @required this.next,
    @required this.results,
  });

  PaginatedResponse fromJson(Map data, M fromJson(Map<String, dynamic> data)) =>
    PaginatedResponse(
      prev: data['prev'] as String,
      next: data['next'] as String,
      results: (data['results'] as List)
        .map((result) => fromJson(result))
        .toBuiltList()
    );

  Map<String, dynamic> toJson() =>
    {
      'prev': prev,
      'next': next,
      'results': results
        .map((result) => result.toJson())
        .toList(),
    };

  @override
  List<Object> get props => [prev, next, results];

  @override
  String toString() =>
    '$runtimeType { '
    '"prev": "$prev", '
    '"next": "$next", '
    '"results": $results, '
    '}';
}
