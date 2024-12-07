import 'package:bmicalculator/Constants/RouteAnimation.dart';
import 'package:bmicalculator/Helper/mobileads.dart';
import 'package:bmicalculator/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    GoogleMobileAds.loadInterstitialAd();
    GoogleMobileAds.loadAboutUsBannerAd();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context)
          .pushReplacement(Routes.createRoute(const HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181822),
      body: Center(child: Lottie.asset("Assets/Lottie/splash_anim.json")),
    );
  }
}
