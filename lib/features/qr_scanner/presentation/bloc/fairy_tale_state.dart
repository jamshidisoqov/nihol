part of 'fairy_tale_bloc.dart';

@freezed
class FairyTaleState with _$FairyTaleState {
  const factory FairyTaleState({
    @Default(Statuses.initial) Statuses status,
    Failure? error,
    QRCodesDto? qrCodes,
    FairyTaleDto? fairyTale,
  }) = _FairyTaleState;
}
