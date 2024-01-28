import 'package:freezed_annotation/freezed_annotation.dart';
part 'qr_codes_dto.g.dart';
part 'qr_codes_dto.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class QRCodesDto with _$QRCodesDto {
  const factory QRCodesDto({
    List<String>? qr_codes,
  }) = _QRCodesDto;

  factory QRCodesDto.fromJson(Map<String, dynamic> json) =>
      _$QRCodesDtoFromJson(json);
}
