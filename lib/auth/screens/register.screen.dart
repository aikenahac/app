import 'package:coinseek/auth/providers/register_fields.provider.dart';
import 'package:coinseek/core/api/api.dart';
import 'package:coinseek/core/router.dart';
import 'package:coinseek/core/widgets/bottom_button.widget.dart';
import 'package:coinseek/core/widgets/nil_app_bar.widget.dart';
import 'package:coinseek/core/widgets/text_field.widget.dart';
import 'package:coinseek/utils/assets.util.dart';
import 'package:coinseek/utils/current_location.util.dart';
import 'package:coinseek/utils/i18n.util.dart';
import 'package:coinseek/utils/snackbar.util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AppTranslations.init(context);

    final displayNameController = ref.watch(displayNameRegisterProvider);
    final emailController = ref.watch(emailRegisterProvider);
    final passwordController = ref.watch(passwordRegisterProvider);
    final confirmPasswordController =
        ref.watch(confirmPasswordRegisterProvider);
    final obscurePasswordController = ref.watch(obscurePaswordRegisterProvider);

    final coinseekRouter = ref.watch(csRouterProvider);

    void register() async {
      if (displayNameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        showSnackbar(tr.enter_all_fields);
        return;
      }

      if (passwordController.text != confirmPasswordController.text) {
        showSnackbar(tr.password_no_match);
        return;
      }

      try {
        await CSApi.auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showSnackbar(tr.weak_password);
        } else if (e.code == 'email-already-in-use') {
          showSnackbar(tr.user_exists);
        }
      } catch (e) {
        return;
      }

      try {
        final currentPos = await getCurrentLocation();
        await CSApi.setDisplayNameAndAnchor(
          displayNameController.text,
          currentPos,
        );
      } catch (e) {
        return;
      }

      coinseekRouter.push(CSRoutes.home);

      displayNameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    }

    return Scaffold(
      appBar: nilAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Image.asset(AppAssets.images.logo),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CSTextField(
                  controller: displayNameController,
                  label: tr.display_name,
                ),
                const SizedBox(height: 10.0),
                CSTextField(
                  controller: emailController,
                  label: tr.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20.0),
                CSTextField(
                  controller: passwordController,
                  label: tr.password,
                  obscured: obscurePasswordController,
                ),
                const SizedBox(height: 10.0),
                CSTextField(
                  controller: confirmPasswordController,
                  label: tr.confirm_password,
                  obscured: obscurePasswordController,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BottomButton(
                  label: tr.register,
                  onPressed: () => register(),
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
