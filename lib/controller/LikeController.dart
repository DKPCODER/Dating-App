import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/Models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikeController extends GetxController {
  // List to store the fetched data from Firebase
  Rx<Person> mydata = Person().obs;
  Rx<Person> likedata = Person().obs;
  RxBool isLoading = false.obs;
  // Filtered list based on search criteria
  RxList<Person> filteredList = <Person>[].obs;
  Future<void> fetchDataFromFirebase() async {
    isLoading.value = true;
    DocumentSnapshot<Map<String, dynamic>> queryDataSnapshot =
        await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();

    mydata.value = Person.fromDataSnapshot(queryDataSnapshot);

    isLoading.value = false;
  }

  Future<void> Fetcher(String id) async {
    isLoading.value = true;
    DocumentSnapshot<Map<String, dynamic>> queryDataSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(id).get();

    likedata.value = Person.fromDataSnapshot(queryDataSnapshot);

    isLoading.value = false;
  }
}
