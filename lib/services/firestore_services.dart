import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:task/helper/shared_preferences.dart';
import 'package:task/model/weight_model.dart';

class Services {
  static Future<void> createUserWeight(Map<String, dynamic> weightModel) async {
    final uid = await SharedPreferencesHelper.getUserId();
    CollectionReference ref =
        FirebaseFirestore.instance.collection('weight');
    ref
        .add(
          weightModel,
        )
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    ;
  }

  static Future<void> updateUserWeight(Weight weight,) async {
    final uid = await SharedPreferencesHelper.getUserId();
    DocumentReference ref =
        FirebaseFirestore.instance.collection('weight').doc(weight.id);

    ref.set({'weight': weight.weight,'timeStamp':weight.timeStamp}) // <-- Your data
        .then((_) => print('Updated'))
        .catchError((error) => print('Update failed: $error'));
  }


  static Future<void> deleteUserWeight( String docID) async {
    final uid = await SharedPreferencesHelper.getUserId();
    DocumentReference ref =
    FirebaseFirestore.instance.collection('weight').doc(docID);

    ref.delete()// <-- Your data
        .then((_) => print('deleted'))
        .catchError((error) => print('delete failed: $error'));
  }

  static Stream<QuerySnapshot> getAllWeights(String? uid) {

    return FirebaseFirestore.instance.collection('weight').snapshots();
  }
}
