import 'package:bmicalculator/Constants/ReUsableCardForHistory.dart';
import 'package:bmicalculator/Providers/HomeScreenProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Constants/styles.dart';

class UserHistoryScreen extends StatefulWidget {
  const UserHistoryScreen({super.key});

  @override
  State<UserHistoryScreen> createState() => _UserHistoryScreenState();
}

class _UserHistoryScreenState extends State<UserHistoryScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);
    print(
        "Length: ${provider.bmihistoryitems.length} And List Of Data Is ${provider.bmihistoryitems}");

    // Calculate the total count to include ads
    final itemCount = provider.bmihistoryitems.length +
        (provider.bmihistoryitems.length ~/ 4);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21232F),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "BMI History",
          style: AppStyles.titlestyle,
        ),
      ),
      body: provider.bmihistoryitems.isEmpty
          ? Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(15.0),
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    color: Colors.grey,
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Oops! You haven't checked your BMI yet.",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                  final dataIndex = index - (index ~/ 4);
                  final eachData = provider.bmihistoryitems[dataIndex];
                  print("EachData Is $eachData");
                  return Card(
                    color: const Color(0xFF0540CA),
                    elevation: 4.0,
                    margin: const EdgeInsets.all(8.0),
                    child: ReUsableCardForHistory(data: eachData),
                  );
              },
            ),
    );
  }
}
