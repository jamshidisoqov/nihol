import 'package:dartz/dartz.dart';


import '../datasource/remote_data_source.dart';
import '/core/resources/failures.dart';
import '../../domain/repo/fairy_tale_repo.dart';
import '../model/fairy_tale_dto.dart';
import '../model/qr_codes_dto.dart';

class FairyTaleRepoImpl extends FairyTaleRepo {
  final FairyTaleRemoteDataSource remoteSource;

  FairyTaleRepoImpl({required this.remoteSource});

  @override
  Future<Either<Failure, FairyTaleDto>> getTale(String qrCode) {
    // TODO: implement getTales
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, QRCodesDto>> getQRCodes() async {
    try {
      final data = await remoteSource.getQRCodes();
      return Right(data);
    } on ServerFailure catch (e) {
      return Left(e);
    }
  }

}