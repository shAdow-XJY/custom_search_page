import 'package:flutter/material.dart';

class CommonSet extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback clearCallback;
  const CommonSet(
      {super.key,
      required this.title,
      required this.children,
      required this.clearCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800),
            ),
            TextButton(
              onPressed: () {
                clearCallback();
              },
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
              child: const Text(
                '恢复默认',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        ...children,
        const Divider(),
      ],
    );
  }
}
