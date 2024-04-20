import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final emailLoginProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final passwordLoginProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());
final obscurePaswordLoginProvider = StateProvider<bool>((ref) => true);
