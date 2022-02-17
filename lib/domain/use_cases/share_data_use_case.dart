import 'package:dartz/dartz.dart';
import 'package:flutter_app/domain/entities/failures/share_data_failure.dart';
import 'package:flutter_app/domain/entities/share_data.dart';
import 'package:flutter_app/utils/share_manager.dart';

class ShareDataUseCase {
  ShareDataUseCase(this._shareManager);

  final ShareManager _shareManager;

  Future<Either<ShareDataFailure, Unit>> execute({
    required ShareData data,
  }) =>
      _shareManager.share(data);
}
