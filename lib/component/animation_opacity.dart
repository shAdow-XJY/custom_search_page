import 'package:flutter/material.dart';

class AnimationOpacity extends StatefulWidget {
  final bool isShow;
  final Widget child;
  const AnimationOpacity({
    super.key,
    required this.isShow,
    required this.child,
  });

  @override
  State<AnimationOpacity> createState() => _BackSetState();
}

class _BackSetState extends State<AnimationOpacity> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isShow ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 800),
          )..forward(),
          curve: Curves.easeInOut,
        ),
        child: widget.child,
      ),
    );
  }
}
