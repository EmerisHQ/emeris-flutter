import 'package:equatable/equatable.dart';
import 'package:flutter_app/domain/entities/pagination.dart';

class PaginatedList<T> extends Equatable {
  const PaginatedList({
    required this.list,
    required this.pagination,
  });

  final List<T> list;
  final Pagination pagination;

  @override
  List<Object> get props => [
        list,
        pagination,
      ];
}
