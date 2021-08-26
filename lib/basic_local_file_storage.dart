library basic_local_file_storage;

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> localFile({required String filePath}) async {
    final path = await _localPath;
    return File('$path/$filePath');
  }

  Future<File> writeFile({required String filePath, required String data}) async {
    final _file = File(filePath);
    return _file.writeAsString(data);
  }

  Future<String> readFile({required String filePath}) async {
    final _file = File(filePath);
    return _file.readAsString();
  }

  Future<void> removeFile({required String filePath}) {
    final _file = File(filePath);
    return _file.delete();
  }

  Future<Directory> createDirectory({required String directoryName}) async {
    final _path = await _localPath;
    final _directory = Directory('$_path/$directoryName');
    return _directory.create();
  }

  //Delete all files in the given directory
  Future<void> clearDirectoryFiles({required String directoryName}) async {
    final _path = await _localPath;
    final directory = Directory('$_path/$directoryName');
    directory.deleteSync(recursive: true);
    await createDirectory(directoryName: directoryName);
  }

  String checkFileSize({required File file}) {
    var bytes = file.lengthSync();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();

    return '${(bytes / pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }
}
