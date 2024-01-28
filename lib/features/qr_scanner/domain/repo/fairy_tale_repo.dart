
import 'package:dartz/dartz.dart';

import '../../../../core/resources/failures.dart';
import '../../data/model/fairy_tale_dto.dart';
import '../../data/model/qr_codes_dto.dart';

abstract class FairyTaleRepo {
  Future<Either<Failure, FairyTaleDto>> getTale(String qrCode);
  Future<Either<Failure, QRCodesDto>> getQRCodes();
}