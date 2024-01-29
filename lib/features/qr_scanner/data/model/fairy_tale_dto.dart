import 'package:freezed_annotation/freezed_annotation.dart';
part 'fairy_tale_dto.g.dart';
part 'fairy_tale_dto.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class FairyTaleDto with _$FairyTaleDto {
  const factory FairyTaleDto({
    String? id,
    List<String>? titles,
    String? titleId,
    List<String>? musics,
    List<String>? qrCodes,
    List<String>? pics,
  }) = _FairyTaleDto;

  factory FairyTaleDto.fromJson(Map<String, dynamic> json) =>
      _$FairyTaleDtoFromJson(json);
}
