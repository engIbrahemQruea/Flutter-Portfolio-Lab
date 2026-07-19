import 'dart:io';

import 'package:dvld/core/helpers/constance.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class ClsUtility {
  ClsUtility._();
  static String generateUUID() {
    return const Uuid().v4();
  }

  static bool createFolderIfDoesNotExist(String folderPath) {
    if (!Directory(folderPath).existsSync()) {
      try {
        Directory(folderPath).createSync(recursive: true);
        return true;
      } on Exception catch (e) {
        return false;
      }
    }
    return true;
  }

  static String replaceFileNameWithUUID(String sourceFile) {
    String extn = p.extension(sourceFile);
    return generateUUID() + extn;
  }

  static String? copyImageToProjectImagesFolder({required String sourceFile}) {
    if (!createFolderIfDoesNotExist(destinationFolder)) {
      return null;
    }

    String fileName = replaceFileNameWithUUID(sourceFile);
    String destinationFile = p.join(destinationFolder, fileName);
    try {
      File(sourceFile).copy(destinationFile);
      return destinationFile;
    } on Exception catch (e) {
      return null;
    }
  }
}
