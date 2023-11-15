import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_mvvm_boilerplate/data/services/base_service/base_service.dart';

import '../../di/container.dart';

class ApiService {
  final BaseService api = inject<BaseService>();

  Future<QuerySnapshot<Object?>> getFirestore ()async{
    return await FirebaseFirestore.instance.collection('user').get();
  } 

  Future <DocumentSnapshot<Map<String, dynamic>>> getDetailFirebase(String userId) async {
    return await FirebaseFirestore.instance.collection('user').doc(userId).get();
  }
  
}
