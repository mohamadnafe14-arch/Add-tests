import 'package:flutter/material.dart';

class SliderText extends StatelessWidget {
  const SliderText({super.key, required Animation<Offset> animation})
    : _animation = animation;

  final Animation<Offset> _animation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: const Text("You can do anything", textAlign: TextAlign.center),
    );
  }
}
