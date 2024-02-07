// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_codes_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QRCodesDtoImpl _$$QRCodesDtoImplFromJson(Map<String, dynamic> json) =>
    _$QRCodesDtoImpl(
      qr_codes: (json['qr_codes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$QRCodesDtoImplToJson(_$QRCodesDtoImpl instance) =>
    <String, dynamic>{
      'qr_codes': instance.qr_codes,
    };
