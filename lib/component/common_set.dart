import 'package:flutter/material.dart';

class CommonSet extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const CommonSet({
    super.key,
    required this.title,
    required this.children
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12.0,),
        Text(
          title,
          style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }
}