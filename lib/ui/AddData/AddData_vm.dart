import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_controller.dart';
import 'package:image_picker/image_picker.dart';

class AddDataScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDataScreenVM>(
      () => AddDataScreenVM(),
    );
  }
}

class AddDataScreenVM extends BaseController {

  
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  ImagePicker picker = ImagePicker();
  RxList<XFile> filesList = <XFile>[].obs;
  RxList<String> phoneList = <String>[].obs;
  
  pickcamaraImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      filesList.add(XFile(image.path));
    }
  }

  pickGallaryImage() async {
    List<XFile> selectedImages = await picker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      filesList.addAll(selectedImages);
    }
  }

  attachFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      filesList.addAll(result.paths.map((path) => XFile(path!)));
    }
  }

  Future<List<String>> uploadImages(List<XFile> filesList) async {
    List<String> downloadUrls = [];

    for (int i = 0; i < filesList.length; i++) {
      var originalFilePath = filesList[i].path;
      var originalFileName = originalFilePath.split('/').last;
      var fileExtension = originalFileName.split('.').last;

      try {
        var result = await firebase_storage.FirebaseStorage.instance
            .ref()
            .child('images')
            .child(originalFileName)
            .putFile(
              File(originalFilePath),
              firebase_storage.SettableMetadata(
                  contentType: 'image/$fileExtension'),
            );

        var downloadUrl = await result.ref.getDownloadURL();

        downloadUrls.add(downloadUrl);
      } on firebase_storage.FirebaseException catch (e) {
        print('Error uploading image: $e');
      }
    }

    return downloadUrls;
  }

  Future<void> saveData(
      String name, String lastname, String province, String phone) async {
    try {
      List<String> imageUrls = await uploadImages(filesList);

      List<String> phoneList = [];
      phoneList.add(phone);

      Map<String, dynamic> result = {
        'name': name,
        'lastName': lastname,
        'province': province,
        'phone_number': phoneList,
        'files': imageUrls,
      };

      await userCollection.add(result);

    Get.back();
    } catch (e) {
      print('Error saving data: $e');
      // Handle error appropriately
    }
  }
}
