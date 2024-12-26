import 'package:bmicalculator/Model/UserDataModel.dart';
import 'package:bmicalculator/Screens/DietPlansScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleMobileAds {
  // Video Ad
  static InterstitialAd? _interstitialAd;
  static bool isAdLoaded = false;

  /// Banner Ad
  static late BannerAd _bannerAd;
  static bool isBannerAdLoaded = false;

  static void loadAboutUsBannerAd() {
    _bannerAd = BannerAd(
      adUnitId:
          'ca-app-pub-4703568558118663/8668876864', // Test Banner Ad Unit ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          isBannerAdLoaded = true;
          print("Banner Ad Loaded");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print("Banner Ad Failed to Load: $error");
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  static loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-4703568558118663/5951214189',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          isAdLoaded = true;
          print("Interstitial Ad Loaded");
          // Optionally set a listener for events
          _interstitialAd?.fullScreenContentCallback =
              FullScreenContentCallback(
            onAdShowedFullScreenContent: (InterstitialAd ad) =>
                print('Ad shown.'),
            onAdDismissedFullScreenContent: (InterstitialAd ad) {
              print('Ad dismissed.');
              ad.dispose();
              loadInterstitialAd(); // Load another ad
            },
            onAdFailedToShowFullScreenContent:
                (InterstitialAd ad, AdError error) {
              print('Failed to show ad: $error');
              ad.dispose();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Interstitial ad failed to load: $error');
        },
      ),
    );
  }

  static void showVideoAd(BuildContext context, UserDataModel model) {
    if (_interstitialAd != null) {
      _interstitialAd!.show();
      _interstitialAd = null;
    } else {
      print('Interstitial ad not ready');
    }
    _moveToNextScreen(context, model);
  }


  static Widget showBannerAd() {
    if (isBannerAdLoaded) {
      return Container(
        alignment: Alignment.center,
        width: _bannerAd.size.width.toDouble(),
        height: _bannerAd.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd),
      );
    } else {
      return const SizedBox(); // Placeholder if ad isn't loaded yet
    }
  }



  static void _moveToNextScreen(BuildContext context, UserDataModel model) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Dietplansscreen(
                age: model.age,
                BMI: model.BMI,
                height: model.height,
                result: model.result,
                weight: model.weight,
              )),
    );
  }
}
