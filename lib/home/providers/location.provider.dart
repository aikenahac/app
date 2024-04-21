import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final currentLocationProvider = StateProvider<LatLng?>((ref) => null);
