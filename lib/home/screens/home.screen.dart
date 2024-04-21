import 'dart:async';

import 'package:coinseek/core/api/api.dart';
import 'package:coinseek/core/router.dart';
import 'package:coinseek/core/widgets/nil_app_bar.widget.dart';
import 'package:coinseek/home/providers/base_error.provider.dart';
import 'package:coinseek/home/providers/data.provider.dart';
import 'package:coinseek/home/providers/location.provider.dart';
import 'package:coinseek/utils/assets.util.dart';
import 'package:coinseek/utils/i18n.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppTranslations.init(context);

    final coinseekRouter = ref.watch(csRouterProvider);

    final currentLatLng = ref.watch(currentLocationProvider);

    final homeData = ref.watch(asyncDataProvider);

    final Completer<GoogleMapController> completer =
        Completer<GoogleMapController>();

    void getCurrentLocation() async {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ref.read(locationErrorProvider.notifier).state =
            tr.location_services_disabled;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ref.read(locationErrorProvider.notifier).state =
              tr.location_disallowed;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ref.read(locationErrorProvider.notifier).state = tr.location_disallowed;
        return;
      }

      final currentPos = await Geolocator.getCurrentPosition();
      ref.read(currentLocationProvider.notifier).state =
          LatLng(currentPos.latitude, currentPos.longitude);
    }

    getCurrentLocation();

    Widget homeBody(Set<Marker> markers) {
      if (currentLatLng == null) {
        return Center(
          child: CircularProgressIndicator(color: AppAssets.colors.black),
        );
      }

      return Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            markers: markers,
            initialCameraPosition: CameraPosition(
              target: currentLatLng,
              zoom: 17.5,
            ),
            onMapCreated: (GoogleMapController controller) {
              completer.complete(controller);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                onPressed: () async {
                  await CSApi.auth.signOut();
                  coinseekRouter.push(CSRoutes.splash);
                },
                child: Icon(Icons.logout, color: AppAssets.colors.black),
              ),
            ),
          ),
        ],
      );
    }

    return homeData.when(
      loading: () => Scaffold(
          body: Center(
              child: CircularProgressIndicator(color: AppAssets.colors.black))),
      error: (err, stack) => const Scaffold(body: Center(child: Text('err'))),
      data: (home) {
        return Scaffold(
          appBar: nilAppBar(),
          body: SlidingUpPanel(
            body: homeBody(home.markers),
            panel: const Placeholder(),
            collapsed: Text("neki"),
            borderRadius: BorderRadius.circular(20.0),
          ),
        );
      },
    );
  }
}
