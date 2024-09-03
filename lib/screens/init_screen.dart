import 'package:flutter/material.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        if (controller.isCompleted) {
          Navigator.popAndPushNamed(context, 'home');
        }
        setState(() {});
      });
    controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/background_icon.png'),
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: SizedBox(
              width: 200,
              child: Align(
                alignment: const Alignment(0, 0.4),
                child: LinearProgressIndicator(
                  color: Colors.white,
                  value: controller.value,
                  semanticsLabel: 'Linear progress indicator',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
