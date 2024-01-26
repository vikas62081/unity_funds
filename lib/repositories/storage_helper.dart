import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageHelper {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImageAndGetURL(String id, File file) async {
    final storageRef = _firebaseStorage.ref().child("images").child('$id.jpg');

    await storageRef.putFile(file);
    String url = await storageRef.getDownloadURL();
    return url;
  }
}
