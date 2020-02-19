import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
class PaginatedResponse<M extends dynamic> with EquatableMixin {
  static final RegExp cursorRegExp = RegExp('cursor=([^&]*)');
  final String prev;
  final String next;
  final BuiltList<M> results;

  String get prevCursor {
    if (prev == null || prev == '')
      return null;
    return cursorRegExp.firstMatch(prev).group(1);
  }

  String get nextCursor {
    if (next == null || next == '')
      return null;
    return cursorRegExp.firstMatch(next).group(1);
  }

  PaginatedResponse({
    @required this.prev,
    @required this.next,
    @required this.results,
  });

  factory PaginatedResponse.fromJson(Map data, M fromJson(Map data)) =>
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
