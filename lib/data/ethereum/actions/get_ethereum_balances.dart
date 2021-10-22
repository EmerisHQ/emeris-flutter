import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/data/ethereum/ethereum_pagination.dart';
import 'package:flutter_app/domain/entities/amount.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/denom.dart';
import 'package:flutter_app/domain/entities/failures/general_failure.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';
import 'package:web3dart/web3dart.dart';

Future<Either<GeneralFailure, PaginatedList<Balance>>> getEthereumBalances(
  Web3Client ethClient,
  String walletAddress,
) async {
  try {
    final balance = await ethClient.getBalance(
      EthereumAddress.fromHex(walletAddress),
    );

    return right(
      PaginatedList(
        list: [
          Balance(
            denom: const Denom('ETH'),
            amount: Amount.fromString(balance.getValueInUnit(EtherUnit.ether).toString()),
            unitPrice: Amount.fromString('0'),
            dollarPrice: Amount.fromString('0'),
          ),
        ],
        pagination: EthereumPagination(),
      ),
    );
  } catch (e, stack) {
    logError(e, stack);
    return left(GeneralFailure.unknown("$e"));
  }
}
