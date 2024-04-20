import 'package:coinseek/core/router.dart';
import 'package:coinseek/core/widgets/bottom_button.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coinseek/utils/assets.util.dart';
import 'package:coinseek/utils/i18n.util.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppTranslations.init(context);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final coinseekRouter = ref.watch(csRouterProvider);

    return Scaffold(
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'CoinSeek',
                style: GoogleFonts.chakraPetch(
                  textStyle: TextStyle(
                    fontSize: 80.0,
                    color: AppAssets.colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BottomButton(
                    label: tr.login,
                    outline: false,
                    onPressed: () {
                      coinseekRouter.push(CSRoutes.login);
                    },
                  ),
                  const SizedBox(height: 10.0),
                  BottomButton(
                    label: tr.register,
                    onPressed: () {
                      coinseekRouter.push(CSRoutes.register);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
