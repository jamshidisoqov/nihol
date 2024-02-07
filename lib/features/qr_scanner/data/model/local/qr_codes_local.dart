import 'package:hive/hive.dart';

part 'qr_codes_local.g.dart';

@HiveType(typeId: 1)
class QrCodesLocal {
  @HiveField(0)
  final List<String> qrCodes;

  QrCodesLocal({required this.qrCodes});
}
