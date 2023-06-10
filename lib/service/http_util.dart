import 'package:http/http.dart' as http;
import 'dart:html' as html;

class HttpUtil {
  static String getBaseHref() {
    html.Element? baseHrefElement = html.querySelector('base[href]');
    String? baseHref = baseHrefElement?.getAttribute('href');
    // print('baseHref: $baseHref');
    return baseHref??'';
  }

  static Future<String> getServerVersion() async {
    final response = await http.get(Uri.parse('${getBaseHref()}version.txt')); // 替换为实际资源版本号文件的URL
    if (response.statusCode == 200) {
      return response.body.trim(); // 返回服务器上的版本号
    } else {
      throw Exception('Failed to fetch server version.');
    }
  }
}
