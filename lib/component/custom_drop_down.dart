import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String value;
  final ValueChanged<String?>? onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 230.0,
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        focusColor: Colors.transparent,
        value: value,
        onChanged: onChanged,
        underline: const SizedBox.shrink(),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            alignment: AlignmentDirectional.center,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
