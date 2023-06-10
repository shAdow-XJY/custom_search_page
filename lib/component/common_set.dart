import 'package:custom_search_page/component/black_white_text_button.dart';
import 'package:flutter/material.dart';

class CommonSet extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final void Function()? clearCallback;
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
            BlackWhiteTextButton(
              onPressed: clearCallback,
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
