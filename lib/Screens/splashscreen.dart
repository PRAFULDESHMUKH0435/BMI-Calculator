import 'package:bmicalculator/Helper/mobileads.dart';
import 'package:flutter/material.dart';

import '../Constants/RouteAnimation.dart';
import 'HomeScreen.dart';

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
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(Routes.createRoute(const HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181822),
      body: Container(
        decoration:const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("Assets/Lottie/splash_anim.gif"))
        ),
      ),
    );
  }
}
