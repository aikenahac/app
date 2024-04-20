import 'package:coinseek/auth/providers/register_fields.provider.dart';
import 'package:coinseek/core/router.dart';
import 'package:coinseek/core/widgets/bottom_button.widget.dart';
import 'package:coinseek/core/widgets/text_field.widget.dart';
import 'package:coinseek/utils/assets.util.dart';
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
    final usernameController = ref.watch(usernameRegisterProvider);
    final emailController = ref.watch(emailRegisterProvider);
    final passwordController = ref.watch(passwordRegisterProvider);
    final confirmPasswordController =
        ref.watch(confirmPasswordRegisterProvider);
    final obscurePasswordController = ref.watch(obscurePaswordRegisterProvider);

    final coinseekRouter = ref.watch(csRouterProvider);

    void register() async {
      if (passwordController.text != confirmPasswordController.text) {
        showSnackbar(tr.password_no_match);
        return;
      }

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppAssets.colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                tr.register,
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
                  controller: displayNameController,
                  label: tr.display_name,
                ),
                const SizedBox(height: 5.0),
                CSTextField(
                  controller: usernameController,
                  label: tr.username,
                ),
                const SizedBox(height: 5.0),
                CSTextField(
                  controller: emailController,
                  label: tr.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15.0),
                CSTextField(
                  controller: passwordController,
                  label: tr.password,
                  obscured: obscurePasswordController,
                ),
                const SizedBox(height: 5.0),
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
                  onPressed: () => {},
                ),
                TextButton(
                  onPressed: () => coinseekRouter.push(CSRoutes.splash),
                  child: Text(tr.go_back),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
