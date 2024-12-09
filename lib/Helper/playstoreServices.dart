import 'package:in_app_review/in_app_review.dart';
import 'package:in_app_update/in_app_update.dart';

class Playstoreservices {
  static final InAppReview inAppReview = InAppReview.instance;

  static void getReviewDialog() async {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
    }
  }

  static Future<void> checkForUpdate() async {
    print('checking for Update');
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        print('update available');
        update();
      }
    }).catchError((e) {
      print("Error Occured while Chgecking Update : ${e.toString()}");
    });
  }

  static void update() async {
    print('Updating');
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
      print("Error Occured while Updating App : ${e.toString()}");
    });
  }
}
