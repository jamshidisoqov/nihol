import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import '../../../home/presentation/widgets/online_tv/device_with_location_dto.dart';
import '../model/fairy_tale_dto.dart';
import '../model/qr_codes_dto.dart';

abstract class FairyTaleRemoteDataSource {
  Future<FairyTaleDto> getTale(String qrCode);

  Future<QRCodesDto> getQRCodes();

}

class FairyTaleRemoteDataSourceImpl extends FairyTaleRemoteDataSource {
  @override
  Future<FairyTaleDto> getTale(String qrCode) async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final response = await ref.child('fairy_tales').get();
      print("cccccccc");
      print(response.value);
      return parseFairyTaleRemoteSource(response.value, qrCode);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<QRCodesDto> getQRCodes() async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final response = await ref.child('qr_codes').get();
      return compute(parseQRCodeRemoteSource, response.value);
    } catch (e) {
      rethrow;
    }
  }

  static QRCodesDto parseQRCodeRemoteSource(data) {
    List<String>? codes = data
        .map((object) => object.toString()) // Convert each element to String
        .toList()
        .cast<String>();
    return QRCodesDto(qr_codes: codes);
  }

  static FairyTaleDto parseFairyTaleRemoteSource(data, qrCode) {
    List<FairyTaleDto> fairyTales = data
        .map(
          (tale) => FairyTaleDto(
            id: tale['id'] as String,
            pics: tale['pics']
                .map((object) =>
                    object.toString()) // Convert each element to String
                .toList()
                .cast<String>(),
            musics: tale['musics']
                .map((object) =>
                    object.toString()) // Convert each element to String
                .toList()
                .cast<String>(),
            qrCodes: tale['qrCodes']
                .map((object) =>
                    object.toString()) // Convert each element to String
                .toList()
                .cast<String>(),
            titles: tale['titles']
                .map((object) =>
                    object.toString()) // Convert each element to String
                .toList()
                .cast<String>(),
            titleId: tale['titleId'] as String,
          ),
        )
        .toList()
        .cast<FairyTaleDto>();

    FairyTaleDto tale = fairyTales.firstWhere((element) {
      bool has = false;
      int length = element.qrCodes?.length ?? 0;
      for (int i = 0; i < length; i++) {
        if (element.qrCodes?[i] == qrCode) {
          has = true;
          break;
        } else {
          continue;
        }
      }
      return has;
    });

    return tale;
  }
}
