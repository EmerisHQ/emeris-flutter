import 'package:cosmos_utils/cosmos_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/share_data_failure.dart';
import 'package:flutter_app/domain/entities/share_data.dart';
import 'package:share_plus/share_plus.dart';

class ShareManager {
  Future<Either<ShareDataFailure, Unit>> share(ShareData data) async {
    try {
      switch (data.type) {
        case ShareDataType.text:
          final textData = data as TextShareData;
          await Share.share(
            textData.text,
            subject: textData.subject,
          );
      }
      return right(unit);
    } catch (ex, stack) {
      logError(ex, stack);
      return left(ShareDataFailure.unknown(ex));
    }
  }
}
