// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fairy_tale_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FairyTaleDtoImpl _$$FairyTaleDtoImplFromJson(Map<String, dynamic> json) =>
    _$FairyTaleDtoImpl(
      id: json['id'] as String?,
      titles:
          (json['titles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      titleId: json['titleId'] as String?,
      musics:
          (json['musics'] as List<dynamic>?)?.map((e) => e as String).toList(),
      qrCodes:
          (json['qrCodes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      pics: (json['pics'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$FairyTaleDtoImplToJson(_$FairyTaleDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titles': instance.titles,
      'titleId': instance.titleId,
      'musics': instance.musics,
      'qrCodes': instance.qrCodes,
      'pics': instance.pics,
    };
