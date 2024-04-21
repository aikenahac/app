import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportLocation {
  const ReportLocation({required this.location});

  final LatLng location;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['location'] = [location.latitude, location.longitude];
    return json;
  }
}
