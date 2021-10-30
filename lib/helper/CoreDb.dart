import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CoreDb {
  ///Creating singleton of CoreDb
  CoreDb._();

  static CoreDb _obj;

  static instance() {
    if (_obj == null) _obj = CoreDb._();
    return _obj;
  }

  ///Getting document path using path provider package
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  ///getting instance of file using localPath
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/preference.json');
  }

  ///function to write data in file
  void writeData(Map data) async {
    File file = await _localFile;
    Map<String, dynamic> tempMap;

    if (await file.exists()) {
      tempMap = json.decode(file.readAsStringSync());
      tempMap.addAll(data);
      file.writeAsStringSync(json.encode(tempMap));
    } else {
      file.writeAsStringSync(json.encode(data));
    }
  }

  ///Function to get all the data in json format
  Future<Map> getData({String key}) async {
    File tempFile = await _localFile;
    if (await tempFile.exists()) {
      return json.decode(tempFile.readAsStringSync());
    } else
      return null;
  }

  ///To delete data if exist in the file
  Future deleteData(
    String dataToDelete,
    Function onDelte,
    Function ifNotExist,
  ) async {
    File tempFile = await _localFile;
    if (!tempFile.existsSync()) {
      ifNotExist();
    } else {
      Map data = json.decode(tempFile.readAsStringSync());
      var result = data.remove(dataToDelete);
      if (result == null) {
        ifNotExist();
      } else {
        tempFile.writeAsStringSync(json.encode(data));
        onDelte();
      }
    }
  }
}
