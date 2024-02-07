part of 'fairy_tale_bloc.dart';

@freezed
class FairyTaleEvent with _$FairyTaleEvent {
  const factory FairyTaleEvent.getQRCodes() = _GetQRCodes;
  const factory FairyTaleEvent.getTales({String? qrCode}) = _GetTales;
  const factory FairyTaleEvent.hasInLocal({FairyTaleLocal? local}) = _HasInLocal;
}
