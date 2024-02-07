import 'package:hive/hive.dart';

part 'fairy_tale_local.g.dart';

@HiveType(typeId: 0)
class FairyTaleLocal {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<String> titles;

  @HiveField(2)
  final String titleId;

  @HiveField(3)
  final List<String> musics;

  @HiveField(4)
  final List<String> qrCodes;

  @HiveField(5)
  final List<String> pics;

  FairyTaleLocal({
    required this.id,
    required this.titles,
    required this.titleId,
    required this.musics,
    required this.qrCodes,
    required this.pics,
  });
}
