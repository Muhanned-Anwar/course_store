import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../../../local/prefs/user_preference_controller.dart';

typedef UploadListener = void Function({
  String? message,
  Reference? reference,
  required bool status,
  required TaskState taskState,
});

class FbStorageController {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> uploadImage({
    required File file,
    required UploadListener uploadListener,
  }) async {
    UploadTask uploadTask =
        _firebaseStorage.ref('images/${DateTime.now()}.png').putFile(file);
    uploadTask.snapshotEvents.listen((event) {
      if (event.state == TaskState.running) {
        uploadListener(status: false, taskState: event.state);
      } else if (event.state == TaskState.success) {
        uploadListener(
          status: true,
          reference: event.ref,
          message: 'Image uploaded successfully',
          taskState: event.state,
        );
      } else if (event.state == TaskState.error) {
        uploadListener(
          status: false,
          message: 'Faild to upload image, something went wrong',
          taskState: event.state,
        );
      }
    });
  }

  Future<List<Reference>> getImages() async {
    ListResult listResult = await _firebaseStorage.ref('images').listAll();
    if (listResult.items.isNotEmpty) {
      return listResult.items;
    }
    return [];
  }

  Future<String> uploadProfileImage({
    required File file,
    required UploadListener uploadListener,
  }) async {
    UploadTask uploadTask = _firebaseStorage
        .ref()
        .child('profile_image')
        .child('${UserPreferenceController().userInformation.id}.png')
        .putFile(file);


    uploadTask.snapshotEvents.listen((event) {
      if (event.state == TaskState.running) {
        print('TaskState.running ${TaskState.running}----------------------------------------------------------');

        uploadListener(status: false, taskState: event.state);
      } else if (event.state == TaskState.success) {
        uploadListener(
          status: true,
          reference: event.ref,
          message: 'Image profile uploaded successfully',
          taskState: event.state,
        );
      } else if (event.state == TaskState.error) {
        print('TaskState.error ${TaskState.error}----------------------------------------------------------');
        uploadListener(
          status: false,
          message: 'Failed to upload image profile, something went wrong',
          taskState: event.state,
        );
      }
    });

    String url = await (await uploadTask).ref.getDownloadURL();
    return url;
  }


  Future<List<Reference>> getImageProfile() async {
    // ListResult listResult = await _firebaseStorage.ref('profile_image').getDownloadURL();
    // if (listResult.items.isNotEmpty) {
    //   return listResult.items;
    // }
    return [];
  }


}
