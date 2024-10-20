// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:your_assistant/features_box.dart';
import 'package:your_assistant/pages/pallete.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int currentIndex = 0;

  // List of texts to be displayed
  final List<String> texts = [
    'Hellooo User, How Can I help you?',
    'Welcome User, How was your day?',
    'What would you like to know today?',
    'I am here to assist you with anything!',
  ];

  @override
  void initState() {
    super.initState();
    // Schedule text switching every 5 seconds
    _cycleTexts();
  }

  // Function to cycle through texts one by one
  void _cycleTexts() {
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) {
        setState(() {
          // Move to the next text in the list
          currentIndex = (currentIndex + 1) % texts.length;
        });
        // Continue cycling through texts
        _cycleTexts();
      }
    });
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Okay',
        onPressed: () {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          _assistantImage(),
          _textBox(),
          const SizedBox(
            height: 28,
          ),
          Container(
            padding: const EdgeInsets.only(left: 28),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Below Are Some Features-',
                style: TextStyle(
                    color: Pallete.mainFontColor,
                    fontSize: 24,
                    fontFamily: 'Cera-Pro',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          _featureBoxes()
        ],
      ),
    );
  }

// features
  Column _featureBoxes() {
    return const Column(
      children: [
        FeaturesBox(
          color: Pallete.firstSuggestionBoxColor,
          headerText: 'ChatGPT',
          descriptionText:
              'ChatGPT is an AI assistant that helps with creativity, coding, problem-solving, and learning, offering personalized support.',
        ),
        FeaturesBox(
          color: Pallete.secondSuggestionBoxColor,
          headerText: 'DAll- E',
          descriptionText:
              'DALL-E is an AI model that generates images from text prompts, creating unique visuals based on user descriptions.',
        ),
      ],
    );
  }

// Chat Message with Typewriter effect
  Container _textBox() {
    return Container(
      height: 100,
      width: 420,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20).copyWith(
          topLeft: Radius.zero,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: TypewriterText(
          key: ValueKey(
              currentIndex), // Ensures the widget rebuilds when index changes
          text: texts[currentIndex],
        ),
      ),
    );
  }

  // Assistant picture
  Stack _assistantImage() {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 120,
            height: 120,
            margin: const EdgeInsets.only(top: 20.4),
            decoration: const BoxDecoration(
              color: Pallete.assistantCircleColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Container(
          height: 128,
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Pallete.borderColor),
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: AssetImage(
                'assets/images/female-lawyer-upper-body-svgrepo-com.png',
              ),
            ),
          ),
        )
      ],
    );
  }

//App Bar
  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Pookie',
        style: TextStyle(
          fontFamily: 'Cera-Pro',
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          showSnackbar(context, 'Menu Options');
        },
        icon: const Icon(
          Icons.menu,
          size: 28,
        ),
      ),
      elevation: 0.0,
    );
  }
}

// TypewriterText widget to handle typewriter effect
class TypewriterText extends StatelessWidget {
  final String text;

  const TypewriterText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        fontFamily: 'Cera-Pro',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Pallete.mainFontColor,
      ),
      child: AnimatedTextKit(
        key: key, // Ensures a fresh animation for every new text
        animatedTexts: [
          TypewriterAnimatedText(
            text,
            speed: const Duration(milliseconds: 100),
          ),
        ],
        totalRepeatCount: 1, // Play the animation once
        pause: const Duration(milliseconds: 500),
        displayFullTextOnTap: true, // Show full text if tapped
        stopPauseOnTap: true, // Stop the pause if tapped
      ),
    );
  }
}
