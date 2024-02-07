// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_codes_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QRCodesDto _$QRCodesDtoFromJson(Map<String, dynamic> json) {
  return _QRCodesDto.fromJson(json);
}

/// @nodoc
mixin _$QRCodesDto {
  List<String>? get qr_codes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QRCodesDtoCopyWith<QRCodesDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QRCodesDtoCopyWith<$Res> {
  factory $QRCodesDtoCopyWith(
          QRCodesDto value, $Res Function(QRCodesDto) then) =
      _$QRCodesDtoCopyWithImpl<$Res, QRCodesDto>;
  @useResult
  $Res call({List<String>? qr_codes});
}

/// @nodoc
class _$QRCodesDtoCopyWithImpl<$Res, $Val extends QRCodesDto>
    implements $QRCodesDtoCopyWith<$Res> {
  _$QRCodesDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? qr_codes = freezed,
  }) {
    return _then(_value.copyWith(
      qr_codes: freezed == qr_codes
          ? _value.qr_codes
          : qr_codes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QRCodesDtoImplCopyWith<$Res>
    implements $QRCodesDtoCopyWith<$Res> {
  factory _$$QRCodesDtoImplCopyWith(
          _$QRCodesDtoImpl value, $Res Function(_$QRCodesDtoImpl) then) =
      __$$QRCodesDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? qr_codes});
}

/// @nodoc
class __$$QRCodesDtoImplCopyWithImpl<$Res>
    extends _$QRCodesDtoCopyWithImpl<$Res, _$QRCodesDtoImpl>
    implements _$$QRCodesDtoImplCopyWith<$Res> {
  __$$QRCodesDtoImplCopyWithImpl(
      _$QRCodesDtoImpl _value, $Res Function(_$QRCodesDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? qr_codes = freezed,
  }) {
    return _then(_$QRCodesDtoImpl(
      qr_codes: freezed == qr_codes
          ? _value.qr_codes
          : qr_codes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QRCodesDtoImpl implements _QRCodesDto {
  const _$QRCodesDtoImpl({this.qr_codes});

  factory _$QRCodesDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$QRCodesDtoImplFromJson(json);

  @override
  final List<String>? qr_codes;

  @override
  String toString() {
    return 'QRCodesDto(qr_codes: $qr_codes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QRCodesDtoImpl &&
            const DeepCollectionEquality().equals(other.qr_codes, qr_codes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(qr_codes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QRCodesDtoImplCopyWith<_$QRCodesDtoImpl> get copyWith =>
      __$$QRCodesDtoImplCopyWithImpl<_$QRCodesDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QRCodesDtoImplToJson(
      this,
    );
  }
}

abstract class _QRCodesDto implements QRCodesDto {
  const factory _QRCodesDto({final List<String>? qr_codes}) = _$QRCodesDtoImpl;

  factory _QRCodesDto.fromJson(Map<String, dynamic> json) =
      _$QRCodesDtoImpl.fromJson;

  @override
  List<String>? get qr_codes;
  @override
  @JsonKey(ignore: true)
  _$$QRCodesDtoImplCopyWith<_$QRCodesDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
