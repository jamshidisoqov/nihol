import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../model/fairy_tale_dto.dart';
import '../model/qr_codes_dto.dart';

abstract class FairyTaleRemoteDataSource {
  Future<FairyTaleDto> getTale(String qrCode);

  Future<QRCodesDto> getQRCodes();
}

class FairyTaleRemoteDataSourceImpl extends FairyTaleRemoteDataSource {

  @override
  Future<FairyTaleDto> getTale(String qrCode) {
    // TODO: implement getTale
    throw UnimplementedError();
  }

  @override
  Future<QRCodesDto> getQRCodes() async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final response = await ref.child('qr_codes').get();
      return compute(parseProfileRemoteSource, response.value);
    } catch (e) {
      rethrow;
    }
  }

  static QRCodesDto parseProfileRemoteSource(data) {
    return QRCodesDto.fromJson(data);
  }

}
