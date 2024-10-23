import 'package:flutter/material.dart';
import 'package:your_assistant/pages/pallete.dart';

class FeaturesBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  final String myImage;

  const FeaturesBox(
      {super.key,
      required this.color,
      required this.headerText,
      required this.descriptionText,
      required this.myImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(
                    myImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: const TextStyle(
                    fontFamily: 'Cera-Pro',
                    color: Pallete.blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              descriptionText,
              style: const TextStyle(
                fontFamily: 'Cera-Pro',
                color: Pallete.blackColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
