import 'package:dartz/dartz.dart';

import '../../data/model/fairy_tale_dto.dart';
import '/core/resources/failures.dart';

import '/core/resources/usecase.dart';
import '../repo/fairy_tale_repo.dart';

class GetTales extends UseCase<FairyTaleDto, String> {
  final FairyTaleRepo repo;

  GetTales({required this.repo});

  @override
  Future<Either<Failure, FairyTaleDto>> call(String params) {
    return repo.getTale(params);
  }

}

