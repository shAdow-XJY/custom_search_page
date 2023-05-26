import 'dart:html' as html;

class ImageLoader {
  static Future<String?> selectAndSetBackgroundImage() async {
    // 在Web平台上选择图片
    final html.InputElement input = html.document.createElement('input') as html.InputElement;
    input
      ..type = 'file'
      ..accept = 'image/*';
    input.click();
    await input.onChange.first;

    final html.File? file = input.files?.first;
    if (file != null) {
      final html.FileReader reader = html.FileReader();
      reader.readAsDataUrl(file);

      await reader.onLoad.first;
      final String encoded = reader.result as String;
      final String imgEncode = encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
      // final Uint8List bytes = base64.decode(stripped);

      return imgEncode;
    }
    return null;
  }

}