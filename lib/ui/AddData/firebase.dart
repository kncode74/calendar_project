import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getx_mvvm_boilerplate/application/base/base_view.dart';
import 'package:getx_mvvm_boilerplate/ui/AddData/firebase_vm.dart';

class FirebaseView extends BaseView<FirebaseViewModel> {
  @override
  Widget render(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('user');
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'name'),
            ),
            ElevatedButton(
              onPressed: () {
                userCollection.doc().update({'data': nameController.text});
              },
              child: Text('save'),
            )
          ],
        ),
      ),
    );
  }
}
