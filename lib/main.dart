
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:plant/screens/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  //await Locales.init(['en', 'ur']);
  //runApp(MyApp());
  runApp(
      EasyLocalization(
      path: 'resources/langs',
      saveLocale: true,
      supportedLocales: const [
        Locale('en', 'EN'),
        //Locale("sn", "SN"),
        Locale('ur', 'UR')
      ],
          child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant Disease Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const SignInScreen(),
    );
  }
}
