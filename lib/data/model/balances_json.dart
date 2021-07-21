import 'package:emeris_app/data/model/emeris_pagination.dart';
import 'package:emeris_app/domain/entities/amount.dart';
import 'package:emeris_app/domain/entities/balance.dart';
import 'package:emeris_app/domain/entities/denom.dart';
import 'package:emeris_app/domain/entities/paginated_list.dart';

class PaginatedBalancesJson {
  late List<BalanceJson> balances;
  late EmerisPagination pagination;

  PaginatedBalancesJson({required this.balances, required this.pagination});

  PaginatedBalancesJson.fromJson(Map<String, dynamic> json) {
    balances = <BalanceJson>[];
    if (json['balances'] != null) {
      if ((json['balances'] as List).isNotEmpty) {
        json['balances'].forEach((v) {
          balances.add(BalanceJson.fromJson(v as Map<String, dynamic>));
        });
      }
    }
    pagination = EmerisPagination.fromJson(json['pagination'] as Map<String, dynamic>);
  }

  PaginatedList<Balance> toDomain() => PaginatedList(
        list: balances
            .map(
              (it) => Balance(
                denom: Denom(it.denom),
                amount: Amount.fromString(it.amount),
              ),
            )
            .toList(),
        pagination: pagination,
      );
}

class BalanceJson {
  late String denom;
  late String amount;

  BalanceJson({required this.denom, required this.amount});

  BalanceJson.fromJson(Map<String, dynamic> json) {
    denom = json['denom'] as String;
    amount = json['amount'] as String;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['denom'] = denom;
    data['amount'] = amount;
    return data;
  }
}
