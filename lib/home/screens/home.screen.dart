import 'dart:async';

import 'package:coinseek/core/api/api.dart';
import 'package:coinseek/core/router.dart';
import 'package:coinseek/core/widgets/nil_app_bar.widget.dart';
import 'package:coinseek/home/providers/data.provider.dart';
import 'package:coinseek/home/widgets/panel_collapsed.widget.dart';
import 'package:coinseek/utils/assets.util.dart';
import 'package:coinseek/utils/i18n.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final Timer updateLocationTimer;

  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    reportCurrentLocation();
    updateLocationTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      reportCurrentLocation();
    });
  }

  @override
  void dispose() {
    super.dispose();
    updateLocationTimer.cancel();
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  void reportCurrentLocation() async {
    final location = await getCurrentLocation();
    if (location == null) return;

    final latlng = LatLng(location.latitude, location.longitude);

    setState(() => currentLocation = latlng);

    final collected = await CSApi.home.reportLocation(latlng);

    if (collected.isNotEmpty) {
      ref.invalidate(asyncDataProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppTranslations.init(context);

    final coinseekRouter = ref.watch(csRouterProvider);
    final homeData = ref.watch(asyncDataProvider);

    final Completer<GoogleMapController> completer =
        Completer<GoogleMapController>();

    Widget homeBody(Set<Marker> markers) {
      if (currentLocation == null) {
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
              target: currentLocation!,
              zoom: 15,
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
                  ref.read(asyncDataProvider.notifier).clear();
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
      error: (err, stack) =>
          Scaffold(body: Center(child: Text(err.toString()))),
      data: (home) {
        return Scaffold(
          appBar: nilAppBar(),
          body: SlidingUpPanel(
            body: homeBody(home.markers),
            panel: Container(),
            collapsed: HomePanelCollapsedWidget(
              balance: home.user?.balance.toString() ?? 'unknown',
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        );
      },
    );
  }
}
