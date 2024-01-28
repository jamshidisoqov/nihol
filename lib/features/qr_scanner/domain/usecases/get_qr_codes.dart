import 'package:dartz/dartz.dart';

import '/core/resources/failures.dart';

import '/core/resources/usecase.dart';
import '../../data/model/qr_codes_dto.dart';
import '../repo/fairy_tale_repo.dart';

class GetQRCodes extends UseCase<QRCodesDto, NoParams> {
  final FairyTaleRepo repo;

  GetQRCodes({required this.repo});

  @override
  Future<Either<Failure, QRCodesDto>> call(NoParams params) async {
    return await repo.getQRCodes();
  }
}

