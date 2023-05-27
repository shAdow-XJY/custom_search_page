import 'package:flutter/cupertino.dart' show CupertinoTextField;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// Just an example of how to use/interpret/format text input's result.
void copyToClipboard(String input) {
  String textToCopy = input.replaceFirst('#', '').toUpperCase();
  if (textToCopy.startsWith('FF') && textToCopy.length == 8) {
    textToCopy = textToCopy.replaceFirst('FF', '');
  }
  Clipboard.setData(ClipboardData(text: '#$textToCopy'));
}

class HSVColorPicker extends StatefulWidget {
  const HSVColorPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;

  @override
  State<HSVColorPicker> createState() => _HSVColorPickerExampleState();
}

class _HSVColorPickerExampleState extends State<HSVColorPicker> {
  
  final textController = TextEditingController(text: '#2F19DB');

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorPicker(
          pickerColor: widget.pickerColor,
          onColorChanged: widget.onColorChanged,
          colorPickerWidth: 330,
          pickerAreaHeightPercent: 0.7,
          enableAlpha: true,
          displayThumbColor: true,
          paletteType: PaletteType.hsvWithHue,
          labelTypes: const [],
          pickerAreaBorderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
          ),
          hexInputController: textController,
          portraitOnly: true,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: CupertinoTextField(
            controller: textController,
            prefix: const Padding(padding: EdgeInsets.only(left: 8), child: Icon(Icons.tag)),
            suffix: IconButton(
              icon: const Icon(Icons.content_paste_rounded),
              onPressed: () => copyToClipboard(textController.text),
            ),
            autofocus: true,
            maxLength: 9,
            inputFormatters: [
              UpperCaseTextFormatter(),
              FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
            ],
          ),
        )
      ],
    );
  }
}