import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

void main() async {
  Directory folder = Directory('E:\\AndroidStudioProjects\\custom_search_page\\docs'); // 替换为实际的文件夹路径
  String hash = await calculateFolderHash(folder);
  print('Folder hash: $hash');
  File versionTxt = File('E:\\AndroidStudioProjects\\custom_search_page\\docs\\version.txt');
  if (!versionTxt.existsSync()) {
    versionTxt.createSync();
  }
  versionTxt.writeAsStringSync(hash);
}

Future<String> calculateFolderHash(Directory folder) async {
  var files = folder.listSync(recursive: true);
  var hashes = <String>[];

  for (var file in files) {
    if (file is File) {
      var content = await file.readAsBytes();
      var hash = sha256.convert(content).toString();
      hashes.add(hash);
    }
  }

  // Sort the hashes to ensure consistent results
  hashes.sort();

  var combinedHash = hashes.join();
  var folderHash = sha256.convert(utf8.encode(combinedHash)).toString();
  return folderHash;
}
