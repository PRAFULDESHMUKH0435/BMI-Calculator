import 'package:bmicalculator/Constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/HomeScreenProvider.dart';
class MaleAndFemaleRow extends StatefulWidget {
  const MaleAndFemaleRow({super.key});

  @override
  State<MaleAndFemaleRow> createState() => _MaleAndFemaleRowState();
}

class _MaleAndFemaleRowState extends State<MaleAndFemaleRow> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);
    return Container(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap:(){
                provider.ismale=true;
              },
              child: Container(
                height: MediaQuery.sizeOf(context).height*.25,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF717880)),
                  borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                  color:provider.ismale?const Color(0xFF043FCB) : const Color(0xFF2D2D37),
                ),
                margin: const EdgeInsets.all(12.0),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        'Assets/Images/male.png', // Placeholder image URL
                      ),
                    ),
                    const SizedBox(width: 10), // Spacing between image and text
                    const Expanded(
                      child: Text(
                        'Male',
                        style: AppStyles.maleandfemaletextstyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap:(){
                provider.ismale=false;
              },
              child: Container(
                height: MediaQuery.sizeOf(context).height*.25,
                margin: const EdgeInsets.all(12.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF717880)),
                  borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                  color: provider.ismale?const Color(0xFF2D2D37): const Color(0xFF043FCB),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Image.asset(
                        'Assets/Images/female.png', // Placeholder image URL
                      ),
                    ),
                    const SizedBox(width: 10), // Spacing between image and text
                    const Expanded(
                      child: Text(
                        'Female',
                        style: AppStyles.maleandfemaletextstyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
