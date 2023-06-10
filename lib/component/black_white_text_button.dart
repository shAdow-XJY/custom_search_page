import 'package:flutter/material.dart';

class BlackWhiteTextButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  const BlackWhiteTextButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        side: MaterialStateProperty.resolveWith<BorderSide>((Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
            return const BorderSide(color: Colors.white);
          }
          return const BorderSide(color: Colors.black);
        }),
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0)),
        overlayColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
            return Colors.black;
          }
          return Colors.white;
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered) || states.contains(MaterialState.pressed)) {
            return Colors.white;
          }
          return Colors.black;
        }),
      ),
      child: child,
    );
  }
}