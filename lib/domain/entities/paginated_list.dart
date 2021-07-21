import 'package:equatable/equatable.dart';
import 'package:emeris_app/domain/entities/pagination.dart';

class PaginatedList<T> extends Equatable {
  final List<T> list;
  final Pagination pagination;

  const PaginatedList({
    required this.list,
    required this.pagination,
  });

  @override
  List<Object> get props => [
        list,
        pagination,
      ];
}
