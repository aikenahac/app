import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final displayNameRegisterProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final emailRegisterProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final passwordRegisterProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final confirmPasswordRegisterProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final obscurePaswordRegisterProvider = StateProvider<bool>((ref) => true);
