import 'package:flutter/material.dart';
import 'package:to_do_app/features/splash/presentation/views/widgets/splash_screen_body.dart';

class SpalshScreen extends StatelessWidget {
  const SpalshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const SplashScreenBody());
  }
}