import 'dart:math';
import 'package:bmicalculator/Helper/playstoreServices.dart';
import 'package:bmicalculator/Hive/UserData.dart';
import 'package:bmicalculator/Services/localnotificationservice.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenProvider with ChangeNotifier {
  ///About Us Screen Expanded
  bool _isexpandedwhoweare = false;
  bool get isexpandedwhoweare => _isexpandedwhoweare;
  set isexpandedwhoweare(bool value) {
    _isexpandedwhoweare = value;
    notifyListeners();
  }

  bool _isexpandedaboutapp = false;
  bool get isexpandedaboutapp => _isexpandedaboutapp;
  set isexpandedaboutapp(bool value) {
    _isexpandedaboutapp = value;
    notifyListeners();
  }


  static GetPlayStoreReviewStatus() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isreviewAdded = sp.containsKey("ReviewAdded")??false;
    print("IsReviewAdded : $isreviewAdded");
    print("BMI History Items Length Is : ${_bmihistoryitems.length}");
    if(isreviewAdded==false && (_bmihistoryitems.length>=3 && _bmihistoryitems.length<=5)){
     print("Inside Show Review Dialog");
       Playstoreservices.getReviewDialog();
       sp.setBool("ReviewAdded", true);
       print("IsReview Status Updated : ${sp.containsKey("ReviewAdded")??false}");
    }
    Playstoreservices.checkForUpdate();
  }

  /// BMI History Items
  var box = Hive.box("BMIHistory");
  static List _bmihistoryitems = Hive.box("BMIHistory").values.toList();
  List get bmihistoryitems => _bmihistoryitems;
  set bmihistoryitems(List value) {
    _bmihistoryitems = value;
    notifyListeners();
  }

  /// BMI Category
  String _bmicategory = "Underweight";
  String get bmicategory => _bmicategory;
  set bmicategory(String value) {
    _bmicategory = value;
    notifyListeners();
  }

  ///BMI Suggestions
  String _BMISuggestions =
      "Eat Healthy Fruits And Increase The Protein And Carbs Intake In Your Daily Diet";
  String get BMISuggestions => _BMISuggestions;
  set BMISuggestions(String value) {
    _BMISuggestions = value;
  }

  /// BMI
  int _BMI = 0;
  int get BMI => _BMI;
  set BMI(int value) {
    _BMI = value;
    notifyListeners();
  }

  ///Gender Selection
  bool _ismale = true;
  bool get ismale => _ismale;
  set ismale(bool value) {
    _ismale = value;
    notifyListeners();
  }

  /// CURRENT SCREEN INDEX
  int _currentscreenidx = 1;
  int get currentscreenidx => _currentscreenidx;
  set currentscreenidx(int value) {
    _currentscreenidx = value;
    notifyListeners();
  }

  /// User Age
  int _userage = 20;
  int get userage => _userage;
  set(int value) {
    _userage = value;
    notifyListeners();
  }

  /// User Height
  double _selectedHeight = 9.11;
  double get selectedHeight => _selectedHeight;
  set selectedHeight(double value) {
    _selectedHeight = value;
    notifyListeners();
  }

  /// User Weight
  int _selectedWeight = 5;
  int get selectedWeight => _selectedWeight;
  set selectedWeight(int value) {
    _selectedWeight = value;
    notifyListeners();
  }

  /// User Age
  int _selectedAge = 5;
  int get selectedAge => _selectedAge;
  set selectedAge(int value) {
    _selectedAge = value;
    notifyListeners();
  }

  // void _moveToNextScreen(BuildContext context,UserDataModel model) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) =>Dietplansscreen(
  //         age: model.age,
  //         BMI: model.BMI,
  //         height: model.height,
  //         result: model.result,
  //         weight: model.weight,
  //       )),
  //     );
  // }

  CalculateUserBMI(BuildContext context) {
    double WeightInKg = selectedWeight.toDouble();
    List<String> monthNames = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'June',
      'July',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    int temp = DateTime.now().month;
    String month = monthNames[temp];

    // Calculate BMI
    debugPrint("Gender ${_ismale ? "Male" : "Female"}");
    debugPrint("Height $selectedHeight");
    debugPrint("Weight $_selectedWeight");
    debugPrint("Age $userage");
    double bmi = WeightInKg / pow(selectedHeight * 0.3048, 2);
    bmi.toStringAsFixed(1);
    BMI = bmi.toInt();
    GetBMICategory(BMI);
    debugPrint("BMI Is ${BMI.toInt()}");
    debugPrint("BMI Category $bmicategory");
    debugPrint("BMI Suggestion $BMISuggestions");
    notifyListeners();

    // Add BMI TO HiveDatabase
    String date = "$month ${DateTime.now().day}, ${DateTime.now().year}";
    print("Current Date Is $date");
    UserData data =
        UserData(date: date, bmi: BMI.toDouble(), bmicategory: bmicategory);
    print("UserData Adding is $data");

    if (bmihistoryitems.length >= 10) {
      bmihistoryitems.removeAt(0);
      bmihistoryitems.add(data);
    } else {
      box.add(data);
      bmihistoryitems.add(data);
      bmihistoryitems.reversed;
      notifyListeners();
    }

    ///Printing BMI History Items
    debugPrint("BMI History Items Are");
    print(bmihistoryitems);
  }

  String GetBMICategory(int bmi) {
    // Category	BMI                       (kg/m2)[c]
    // Underweight (Severe thinness)	      < 16.0
    // Underweight (Moderate thinness)	    16.0 – 16.9
    // Underweight (Mild thinness)	        17.0 – 18.4
    // Normal range                       	18.5 – 24.9
    // Overweight (Pre-obese)             	25.0 – 29.9
    // Obese (Class II)                   	35.0 – 39.9
    // Obese (Class III)                   	≥ 40.0

    switch (bmi) {
      case >= 1 && < 18.5:
        bmicategory = "Underweight";
        break;

      case >= 18.5 && <= 24.9:
        bmicategory = "Normal";
        break;

      case >= 25.0 && < 30.0:
        bmicategory = "OverWeight";
        break;

      case >= 30.0 && <= 1000:
        bmicategory = "Obese";
        break;
    }
    notifyListeners();
    debugPrint("Category Passes Is $bmicategory");
    GetBMISuggestions(bmicategory);
    if (bmicategory == "Obese" ||
        bmicategory == "OverWeight" ||
        bmicategory == "Underweight") {
      Localnotificationservice.ScheduleNotification(bmicategory);
    }
    return bmicategory;
  }

  String GetBMISuggestions(String category) {
    switch (category) {
      case "Underweight":
        BMISuggestions =
            "Eat Healthy Fruits And Increase The Protein And Carbs Intake In Your Daily Diet";
        break;

      case "Normal":
        BMISuggestions =
            "Your BMI Is Normal Keep It Maintain And Do Follow Your Diet";
        break;

      case "OverWeight":
        BMISuggestions =
            "You Have Slightly Higher BMI Than Normal Just Do Exercise More And Maintain Your Diet";
        break;

      case "Obese":
        BMISuggestions =
            "Choose Healthier Foods And Do More Regular Physical Activities To Reduce The Risks ";
        break;
    }
    notifyListeners();
    return BMISuggestions;
  }
}
