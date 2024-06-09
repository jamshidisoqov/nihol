// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fairy_tale_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FairyTaleDto _$FairyTaleDtoFromJson(Map<String, dynamic> json) {
  return _FairyTaleDto.fromJson(json);
}

/// @nodoc
mixin _$FairyTaleDto {
  String? get id => throw _privateConstructorUsedError;
  List<String>? get titles => throw _privateConstructorUsedError;
  String? get titleId => throw _privateConstructorUsedError;
  List<String>? get musics => throw _privateConstructorUsedError;
  List<String>? get qrCodes => throw _privateConstructorUsedError;
  List<String>? get pics => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FairyTaleDtoCopyWith<FairyTaleDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FairyTaleDtoCopyWith<$Res> {
  factory $FairyTaleDtoCopyWith(
          FairyTaleDto value, $Res Function(FairyTaleDto) then) =
      _$FairyTaleDtoCopyWithImpl<$Res, FairyTaleDto>;
  @useResult
  $Res call(
      {String? id,
      List<String>? titles,
      String? titleId,
      List<String>? musics,
      List<String>? qrCodes,
      List<String>? pics});
}

/// @nodoc
class _$FairyTaleDtoCopyWithImpl<$Res, $Val extends FairyTaleDto>
    implements $FairyTaleDtoCopyWith<$Res> {
  _$FairyTaleDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? titles = freezed,
    Object? titleId = freezed,
    Object? musics = freezed,
    Object? qrCodes = freezed,
    Object? pics = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      titles: freezed == titles
          ? _value.titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      titleId: freezed == titleId
          ? _value.titleId
          : titleId // ignore: cast_nullable_to_non_nullable
              as String?,
      musics: freezed == musics
          ? _value.musics
          : musics // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      qrCodes: freezed == qrCodes
          ? _value.qrCodes
          : qrCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      pics: freezed == pics
          ? _value.pics
          : pics // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FairyTaleDtoImplCopyWith<$Res>
    implements $FairyTaleDtoCopyWith<$Res> {
  factory _$$FairyTaleDtoImplCopyWith(
          _$FairyTaleDtoImpl value, $Res Function(_$FairyTaleDtoImpl) then) =
      __$$FairyTaleDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      List<String>? titles,
      String? titleId,
      List<String>? musics,
      List<String>? qrCodes,
      List<String>? pics});
}

/// @nodoc
class __$$FairyTaleDtoImplCopyWithImpl<$Res>
    extends _$FairyTaleDtoCopyWithImpl<$Res, _$FairyTaleDtoImpl>
    implements _$$FairyTaleDtoImplCopyWith<$Res> {
  __$$FairyTaleDtoImplCopyWithImpl(
      _$FairyTaleDtoImpl _value, $Res Function(_$FairyTaleDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? titles = freezed,
    Object? titleId = freezed,
    Object? musics = freezed,
    Object? qrCodes = freezed,
    Object? pics = freezed,
  }) {
    return _then(_$FairyTaleDtoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      titles: freezed == titles
          ? _value.titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      titleId: freezed == titleId
          ? _value.titleId
          : titleId // ignore: cast_nullable_to_non_nullable
              as String?,
      musics: freezed == musics
          ? _value.musics
          : musics // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      qrCodes: freezed == qrCodes
          ? _value.qrCodes
          : qrCodes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      pics: freezed == pics
          ? _value.pics
          : pics // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FairyTaleDtoImpl implements _FairyTaleDto {
  const _$FairyTaleDtoImpl(
      {this.id,
      this.titles,
      this.titleId,
      this.musics,
      this.qrCodes,
      this.pics});

  factory _$FairyTaleDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FairyTaleDtoImplFromJson(json);

  @override
  final String? id;
  @override
  final List<String>? titles;
  @override
  final String? titleId;
  @override
  final List<String>? musics;
  @override
  final List<String>? qrCodes;
  @override
  final List<String>? pics;

  @override
  String toString() {
    return 'FairyTaleDto(id: $id, titles: $titles, titleId: $titleId, musics: $musics, qrCodes: $qrCodes, pics: $pics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FairyTaleDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.titles, titles) &&
            (identical(other.titleId, titleId) || other.titleId == titleId) &&
            const DeepCollectionEquality().equals(other.musics, musics) &&
            const DeepCollectionEquality().equals(other.qrCodes, qrCodes) &&
            const DeepCollectionEquality().equals(other.pics, pics));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      const DeepCollectionEquality().hash(titles),
      titleId,
      const DeepCollectionEquality().hash(musics),
      const DeepCollectionEquality().hash(qrCodes),
      const DeepCollectionEquality().hash(pics));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FairyTaleDtoImplCopyWith<_$FairyTaleDtoImpl> get copyWith =>
      __$$FairyTaleDtoImplCopyWithImpl<_$FairyTaleDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FairyTaleDtoImplToJson(
      this,
    );
  }
}

abstract class _FairyTaleDto implements FairyTaleDto {
  const factory _FairyTaleDto(
      {final String? id,
      final List<String>? titles,
      final String? titleId,
      final List<String>? musics,
      final List<String>? qrCodes,
      final List<String>? pics}) = _$FairyTaleDtoImpl;

  factory _FairyTaleDto.fromJson(Map<String, dynamic> json) =
      _$FairyTaleDtoImpl.fromJson;

  @override
  String? get id;
  @override
  List<String>? get titles;
  @override
  String? get titleId;
  @override
  List<String>? get musics;
  @override
  List<String>? get qrCodes;
  @override
  List<String>? get pics;
  @override
  @JsonKey(ignore: true)
  _$$FairyTaleDtoImplCopyWith<_$FairyTaleDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
