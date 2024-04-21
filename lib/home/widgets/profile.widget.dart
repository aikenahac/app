import 'package:coinseek/core/api/api.dart';
import 'package:coinseek/core/widgets/bottom_button.widget.dart';
import 'package:coinseek/core/widgets/text_field.widget.dart';
import 'package:coinseek/home/providers/data.provider.dart';
import 'package:coinseek/home/widgets/pfp.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Profile extends ConsumerWidget {
  const Profile({
    super.key,
    required this.location,
    required this.onLogout,
  });

  final LatLng? location;
  final Function onLogout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(asyncDataProvider);
    final nameController = TextEditingController(text: data.value?.user?.name);

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16.0),
            const Text('Profile', style: TextStyle(fontSize: 32.0)),
            const SizedBox(height: 24.0),
            const PfpWidget(radius: 42.0),
            const SizedBox(height: 36.0),
            CSTextField(
              controller: nameController,
              label: "Name",
            ),
            const SizedBox(height: 36.0),
            BottomButton(
              label: "Set anchor point",
              onPressed: () async {
                CSApi.home
                    .updateAnchorPoint(location!)
                    .then((_) => context.pop());
              },
            ),
            const SizedBox(height: 16.0),
            BottomButton(
              label: "Save",
              onPressed: () {
                CSApi.home.updateName(nameController.text).then((_) {
                  ref.invalidate(asyncDataProvider);
                  context.pop();
                });
              },
            ),
            const SizedBox(height: 16.0),
            BottomButton(
              label: "Logout",
              onPressed: () {
                onLogout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
