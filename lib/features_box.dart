import 'package:flutter/material.dart';
import 'package:your_assistant/pages/pallete.dart';

class FeaturesBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  const FeaturesBox(
      {super.key,
      required this.color,
      required this.headerText,
      required this.descriptionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 36),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20)
            .copyWith(left: 16, right: 8),
        child: Column(
          children: [
            Text(
              headerText,
              style: const TextStyle(
                  fontFamily: 'Cera-Pro',
                  color: Pallete.blackColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              descriptionText,
              style: const TextStyle(
                  fontFamily: 'Cera-Pro',
                  color: Pallete.blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
