import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

final String baseUrl = '${dotenv.env['API_URL']}';
