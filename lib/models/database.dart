import 'dart:io';

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


}
