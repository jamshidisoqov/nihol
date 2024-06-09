
class DeviceWithLocation {
  final double lon;
  final String deviceId;
  final String deviceName;
  final double lat;

  DeviceWithLocation({
    required this.lon,
    required this.deviceId,
    required this.deviceName,
    required this.lat,
  });

  factory DeviceWithLocation.fromJson(json) {
    return DeviceWithLocation(
      lon:  json['lon'] ?? 0.0,
      deviceId: json['deviceId'] ?? '',
      deviceName: json['deviceName'] ?? '',
      lat: json['lat'] ?? 0.0,
    );
  }
}
