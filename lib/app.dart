import 'package:coinseek/core/globals.dart';
import 'package:coinseek/core/router.dart';
import 'package:coinseek/utils/assets.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coinseekRouter = ref.watch(csRouterProvider);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        alwaysUse24HourFormat: true,
      ),
      child: MaterialApp.router(
        scaffoldMessengerKey: snackbarKey,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: GoogleFonts.poppins().fontFamily,
          scaffoldBackgroundColor: AppAssets.colors.white,
          primaryColor: AppAssets.colors.black,
          colorScheme: ColorScheme.light(
            primary: AppAssets.colors.black,
          ),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: AppAssets.colors.black,
                displayColor: AppAssets.colors.black,
              ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: coinseekRouter,
      ),
    );
  }
}
