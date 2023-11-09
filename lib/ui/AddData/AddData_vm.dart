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
  XFile? selectedImage;

  // Function to select an image from the gallery
  Future<void> selectImageFromGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = image;
      update(); // Notify the UI that the image has been updated
    }
  }

  // Function to capture an image using the camera
  Future<void> captureImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage = image;
      update(); // Notify the UI that the image has been updated
    }
  }

  saveData(String name, String lastname, String province, String phone) {
    Map<String, dynamic> result = {
      'name': name,
      'lastName': lastname,
      'province': province,
      'phone_number': phone
    };
    print('dddddddddddddddd $result');
    Get.back(result: result);
  }
}
