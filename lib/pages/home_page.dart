// ignore_for_file: camel_case_types, unused_field

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:your_assistant/features_box.dart';
import 'package:your_assistant/pages/pallete.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int currentIndex = 0;
  final _speechToText = SpeechToText();
  String lastwords = '';

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
    _cycleTexts();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    await _speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await _speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastwords = result.recognizedWords;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _speechToText.stop();
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _assistantImage(),
            _textBox(),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.only(left: 28),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Below Are Some Features-',
                  style: TextStyle(
                      color: Pallete.mainFontColor,
                      fontSize: 20,
                      fontFamily: 'Cera-Pro',
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            _featureBoxes()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showSnackbar(context, 'Currently Not Working');
          if (await _speechToText.hasPermission &&
              _speechToText.isNotListening) {
            await startListening();
          } else if (_speechToText.isListening) {
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        backgroundColor: Pallete.firstSuggestionBoxColor,
        child: const Icon(Icons.mic),
      ),
    );
  }

// features
  Column _featureBoxes() {
    return const Column(
      children: [
        FeaturesBox(
          color: Pallete.firstSuggestionBoxColor,
          myImage: 'assets/images/chat-gpt.png',
          headerText: 'ChatGPT',
          descriptionText:
              'ChatGPT assists with ideas, coding, and creative solutions efficiently daily.',
        ),
        FeaturesBox(
          color: Pallete.secondSuggestionBoxColor,
          myImage: 'assets/images/artificial-intelligence.png',
          headerText: 'DAll- E',
          descriptionText:
              'DALL-E generates detailed images based on prompts, bringing creative visions to life.',
        ),
        FeaturesBox(
          color: Pallete.thirdSuggestionBoxColor,
          myImage: 'assets/images/voice-assistant.png',
          headerText: 'Smart Voice Assistant',
          descriptionText:
              'The Smart Voice Assistant listens, processes commands, and simplifies tasks with quick, accurate responses.',
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
            margin: const EdgeInsets.only(top: 12),
            decoration: const BoxDecoration(
              color: Pallete.assistantCircleColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Container(
          height: 128,
          margin: const EdgeInsets.only(top: 2),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
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
