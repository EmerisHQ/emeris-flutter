import 'package:emeris_app/domain/entities/pagination.dart';

class EmerisPagination implements Pagination {
  @override
  final String nextKey;
  late String total;

  EmerisPagination({
    required this.nextKey,
    required this.total,
  });

  EmerisPagination.fromJson(Map<String, dynamic> json)
      : nextKey = (json['next_key'] ?? "") as String,
        total = json['total'] as String;
}
