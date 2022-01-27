import 'package:flutter_app/domain/entities/pagination.dart';

class PoolPagination implements Pagination {
  @override
  final String nextKey;
  final String total;

  PoolPagination({
    required this.nextKey,
    required this.total,
  });

  factory PoolPagination.fromJson(Map<String, dynamic> json) =>
      PoolPagination(nextKey: (json['next_key'] ?? "") as String, total: json['total'] as String);
}
