// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:journalapp/data/database.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseFileRoutines {
  // method that returns a future string which is the document directory path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // method that returns a future file with the reference to the
  //local_persistence.json file , which is the path combined with the filename
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/local_persistence.json');
  }

  Future<String> readJournals() async {
    try {
      final file = await _localFile;
      if (!file.existsSync()) {
        print("File does not Exist: ${file.absolute}");
        await writeJournals('{"journals": []}');
      }

      // read the file
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      print("error readJournals: $e");
      return "";
    }
  }

  Future<File> writeJournals(String json) async {
    final file = await _localFile;

    // write the file
    return file.writeAsString(json);
  }

  // method to read and parse from json data
  static Database datebaseFromJson(String str) {
    final dataFromJson = json.decode(str);
    return Database.fromJson(dataFromJson);
  }

  // method to save and parse to json data
  static String databaseToJson(Database data) {
    final dataToJson = data.toJson();
    return json.encode(dataToJson);
  }
}
