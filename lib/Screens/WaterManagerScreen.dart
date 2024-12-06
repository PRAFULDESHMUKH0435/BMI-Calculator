import 'package:flutter/material.dart';

import '../Constants/styles.dart';

class WaterManagerScreen extends StatelessWidget {
  const WaterManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF21232F),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Water Manager",
          style: AppStyles.titlestyle,
        ),
      ),
    );
  }
}