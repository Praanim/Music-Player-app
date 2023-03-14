import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_app/constants/color_pallete.dart';
import 'package:music_player_app/presentation/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player App',
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Constants.mainBackgrdColor,
          appBarTheme: const AppBarTheme(
              color: Colors.transparent, elevation: 0, centerTitle: true),
          textTheme: GoogleFonts.lancelotTextTheme()),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
