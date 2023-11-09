import 'package:image_picker/image_picker.dart';

class User {
  final String name;
  final String lastName;
  final String province;
  List<String>? phoneNumbers;
  List<XFile>? imageFiles; 
  List<XFile>? documentFiles; 

  User(this.name, this.lastName, this.province, this.phoneNumbers, this.imageFiles, this.documentFiles);
}
