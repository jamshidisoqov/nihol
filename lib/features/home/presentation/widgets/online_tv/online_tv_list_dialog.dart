import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/widgets/w_dialog_container.dart';
import 'device_with_location_dto.dart';

class OnlineTvDialog extends StatefulWidget {
  final SharedPreferences prefs;
  final deviceNameKey = "device_name";
  final deviceIdKey = "device_id";
  final deviceTvSend = "send_tv";

  const OnlineTvDialog({super.key, required this.prefs});

  @override
  State<OnlineTvDialog> createState() => _WSettingsDialogState();

  Future<List<DeviceWithLocation>> getAllDevices(double lat, double lon) async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final response = await ref.child('device_locations').get();
      return (response.value as Map<Object?, Object?>)
          .values
          .map((e) => DeviceWithLocation.fromJson(e as dynamic))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}

class _WSettingsDialogState extends State<OnlineTvDialog> {
  late bool isSoundOn = true;
  late bool isMusicOn = true;
  late bool isSendTv = true;

  @override
  void initState() {
    super.initState();
    isSoundOn = widget.prefs.getBool('sound') ?? true;
    isMusicOn = widget.prefs.getBool('music') ?? true;
    isSendTv = widget.prefs.getBool(widget.deviceTvSend) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: WTvListContainer(
          child: Text("List"),
        ),
      ),
    );
  }
}
