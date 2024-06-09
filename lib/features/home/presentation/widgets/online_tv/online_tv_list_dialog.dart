import 'dart:math';

import 'package:auto_route/auto_route.dart';
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

  OnlineTvDialog({super.key, required this.prefs});

  @override
  State<OnlineTvDialog> createState() => _WSettingsDialogState();
}

class _WSettingsDialogState extends State<OnlineTvDialog> {
  late bool isSoundOn = true;
  late bool isMusicOn = true;
  late bool isSendTv = true;
  List<DeviceWithLocation> deviceList = List.empty();

  void getAllDevices(double lat, double lon) async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final response = await ref.child('device_locations').get();
      deviceList = (response.value as Map<Object?, Object?>)
          .values
          .map((e) => DeviceWithLocation.fromJson(e as dynamic))
          .toList();
      print(deviceList.length);
      setState(() {});
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    getAllDevices(0.0, 0.0);
    isSoundOn = widget.prefs.getBool('sound') ?? true;
    isMusicOn = widget.prefs.getBool('music') ?? true;
    isSendTv = widget.prefs.getBool(widget.deviceTvSend) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      buttonPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: WTvListContainer(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'TV-SMART',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      DeviceWithLocation device = deviceList[index];
                      String name = device.deviceName;
                      return InkWell(
                        onTap:() {
                          widget.prefs.setString(widget.deviceIdKey,device.deviceId);
                          widget.prefs.setString(widget.deviceNameKey,device.deviceName);
                          widget.prefs.setBool(widget.deviceTvSend,true);
                          context.router.maybePop();
                        },
                        child: Column(
                          children: [
                            Text(
                              "${index + 1}.${name.substring(0, min(name.length, 12))}",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 28,
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                              height: 24,
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: deviceList.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
