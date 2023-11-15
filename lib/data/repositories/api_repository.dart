import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_mvvm_boilerplate/models/user_model.dart';

import '../../di/container.dart';
import '../services/api_service.dart';

class ApiRepository {
  final ApiService _service = inject<ApiService>();
  
  Future<List<User>> getUser() async {
    QuerySnapshot querySnapshot = await _service.getFirestore();
    return querySnapshot.docs.map((user) {
      List<String> phoneNumbers = (user['phone_number'] as List<dynamic>)
          .map((dynamic number) => number.toString())
          .toList();
      List<String> fileList = (user['files'] as List<dynamic>)
          .map((dynamic number) => number.toString())
          .toList();
      return User(
        user['name'],
        user['lastName'],
        user['province'],
        phoneNumbers,
        fileList,
        user.id,
      );
    }).toList();
  }

  Future<User?> getDetailUser(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> userGet =
        await _service.getDetailFirebase(userId);
    if (!userGet.exists) return null;

    List<String> phoneNumbers = (userGet['phone_number'] as List<dynamic>)
        .map((dynamic number) => number.toString())
        .toList();
    List<String> fileList = (userGet['files'] as List<dynamic>)
        .map((dynamic number) => number.toString())
        .toList();
    return User(
      userGet['name'],
      userGet['lastName'],
      userGet['province'],
      phoneNumbers,
      fileList,
      userId,
    );
  }
}
