import 'package:file_picker/file_picker.dart';
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
  ImagePicker picker = ImagePicker();
  RxList<XFile> filesList = <XFile>[].obs;

  pickcamaraImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      filesList.add(XFile(image.path));
    }
    print('dddddd $filesList');
  }

  pickGallaryImage() async {
    List<XFile> selectedImages = await picker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      filesList.addAll(selectedImages);
    }
    print('wwwwwwwww $filesList');
  }

  attachFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      filesList.addAll(result.paths.map((path) => XFile(path!)));
    }
    print('wwwwwwwww $filesList');
  }

  saveData(String name, String lastname, String province, String phone) {
    var rs = filesList.map((file) => file.path).toList();
    Map<String, dynamic> result = {
      'name': name,
      'lastName': lastname,
      'province': province,
      'phone_number': phone,
      'files': rs
      // 'files': filesList.map((file) => file.path).toList()
    };
    print('22222 $rs');
    print('dddddddddddddddd $result');
    Get.back(result: result);
  }
}
