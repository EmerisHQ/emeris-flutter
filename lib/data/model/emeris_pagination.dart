import 'package:flutter_app/domain/entities/pagination.dart';

class EmerisPagination implements Pagination {
  @override
  final String nextKey;
  final String total;

  EmerisPagination({
    required this.nextKey,
    required this.total,
  });

  factory EmerisPagination.fromJson(Map<String, dynamic> json) =>
      EmerisPagination(nextKey: (json['next_key'] ?? "") as String, total: json['total'] as String);
}
