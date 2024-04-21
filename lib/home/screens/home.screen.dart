import 'dart:async';

import 'package:coinseek/core/api/api.dart';
import 'package:coinseek/core/router.dart';
import 'package:coinseek/home/providers/add_friend.provider.dart';
import 'package:coinseek/home/providers/data.provider.dart';
import 'package:coinseek/home/providers/requests.provider.dart';
import 'package:coinseek/home/widgets/friend_request.widget.dart';
import 'package:coinseek/home/widgets/leaderboard.widget.dart';
import 'package:coinseek/home/widgets/map_fab.widget.dart';
import 'package:coinseek/home/widgets/panel_collapsed.widget.dart';
import 'package:coinseek/home/widgets/pfp.widget.dart';
import 'package:coinseek/home/widgets/powerup.widget.dart';
import 'package:coinseek/home/widgets/profile.widget.dart';
import 'package:coinseek/utils/assets.util.dart';
import 'package:coinseek/utils/current_location.util.dart';
import 'package:coinseek/utils/i18n.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pixelarticons/pixel.dart';
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
    updateLocationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      reportCurrentLocation();
    });
  }

  @override
  void dispose() {
    super.dispose();
    updateLocationTimer.cancel();
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

    final homeData = ref.watch(asyncDataProvider);
    final requestsData = ref.watch(asyncRequestsProvider);
    final coinseekRouter = ref.watch(csRouterProvider);

    final Completer<GoogleMapController> completer =
        Completer<GoogleMapController>();

    void friendRequestsModalSheet() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 60.0,
                  child: TextField(
                    controller: ref.watch(addFriendControllerProvider),
                    decoration: textFieldDecoration,
                    style: GoogleFonts.poppins(),
                    cursorColor: AppAssets.colors.black,
                    cursorHeight: 20.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  tr.requests,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppAssets.colors.black,
                  ),
                ),
                const SizedBox(height: 5.0),
                requestsData.when(
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color: AppAssets.colors.black,
                    ),
                  ),
                  error: (err, stack) => Center(child: Text(err.toString())),
                  data: (requests) {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: requests.length,
                        itemBuilder: (c, i) => FriendRequestWidget(
                          user: requests[i],
                          onAccept: () {
                            ref.invalidate(asyncRequestsProvider);
                            context.pop();
                          },
                        ),
                        separatorBuilder: (c, i) => const SizedBox(height: 5.0),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    void powerupsModalSheet() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  tr.powerups,
                  style: TextStyle(
                    color: AppAssets.colors.black,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                PowerupWidget(
                  name: tr.blindness_powerup,
                  description: tr.blindness_powerup_description,
                  icon: AppAssets.images.blindOthersPowerup,
                ),
                PowerupWidget(
                  name: tr.multiplier_powerup,
                  description: tr.multiplier_powerup_description,
                  icon: AppAssets.images.spawnMultiplierPowerup,
                ),
              ],
            ),
          );
        },
      );
    }

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
              zoom: 13,
            ),
            onMapCreated: (GoogleMapController controller) {
              completer.complete(controller);
            },
          ),
          SafeArea(
              child: Stack(
            children: [
              MapFabWidget(
                alignment: Alignment.topRight,
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (context) => Profile(
                      location: currentLocation,
                      onLogout: () async {
                        updateLocationTimer.cancel();
                        await CSApi.auth.signOut();
                        ref.read(asyncDataProvider.notifier).clear();
                        coinseekRouter.pushReplacement(CSRoutes.splash);
                      },
                    ),
                  );
                },
                child: const PfpWidget(),
              ),
              MapFabWidget(
                alignment: Alignment.topLeft,
                onTap: friendRequestsModalSheet,
                child: CircleAvatar(
                  child: Icon(Pixel.users, color: AppAssets.colors.black),
                ),
              ),
              MapFabWidget(
                alignment: Alignment.centerRight,
                onTap: powerupsModalSheet,
                child: CircleAvatar(
                  child: Icon(Pixel.zap, color: AppAssets.colors.black),
                ),
              ),
            ],
          ))
        ],
      );
    }

    return homeData.when(
      loading: () => Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppAssets.colors.black),
        ),
      ),
      error: (err, stack) =>
          Scaffold(body: Center(child: Text(err.toString()))),
      data: (home) {
        return Scaffold(
          // appBar: nilAppBar(),
          body: SlidingUpPanel(
            body: homeBody(home.markers),
            panel: const Leaderboard(),
            collapsed: HomePanelCollapsedWidget(
              balance: home.user?.balance.toString() ?? '0',
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
        );
      },
    );
  }
}

InputDecoration textFieldDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: AppAssets.colors.black.withOpacity(0.4),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(color: AppAssets.colors.darkGreen),
  ),
  prefixIcon: const Icon(Pixel.userplus),
  prefixIconColor: AppAssets.colors.black,
  suffix: IconButton(
    onPressed: () {},
    icon: Icon(
      Pixel.arrowright,
      color: AppAssets.colors.black,
    ),
  ),
  hintText: tr.enter_friend_email,
);
