import 'package:coinseek/auth/providers/login_fields.provider.dart';
import 'package:coinseek/core/api/api.dart';
import 'package:coinseek/core/router.dart';
import 'package:coinseek/core/widgets/bottom_button.widget.dart';
import 'package:coinseek/core/widgets/nil_app_bar.widget.dart';
import 'package:coinseek/core/widgets/text_field.widget.dart';
import 'package:coinseek/home/providers/data.provider.dart';
import 'package:coinseek/utils/assets.util.dart';
import 'package:coinseek/utils/i18n.util.dart';
import 'package:coinseek/utils/snackbar.util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppTranslations.init(context);

    final emailController = ref.watch(emailLoginProvider);
    final passwordController = ref.watch(passwordLoginProvider);
    final obscurePasswordController = ref.watch(obscurePaswordLoginProvider);

    final coinseekRouter = ref.watch(csRouterProvider);

    void login() async {
      try {
        await CSApi.auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showSnackbar(tr.no_user_found);
        } else if (e.code == 'wrong-password') {
          showSnackbar(tr.wrong_password);
        }
        return;
      } catch (e) {
        return;
      }

      ref.invalidate(asyncDataProvider);
      coinseekRouter.push(CSRoutes.home);

      emailController.clear();
      passwordController.clear();
    }

    return Scaffold(
      appBar: nilAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                tr.login,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36.0,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CSTextField(
                  controller: emailController,
                  label: tr.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10.0),
                CSTextField(
                  controller: passwordController,
                  label: tr.password,
                  obscured: obscurePasswordController,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BottomButton(
                  label: tr.login,
                  onPressed: () => login(),
                ),
                TextButton(
                  onPressed: () => coinseekRouter.push(CSRoutes.splash),
                  child: Text(
                    tr.go_back,
                    style: TextStyle(
                      color: AppAssets.colors.black,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
