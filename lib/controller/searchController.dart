import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/Models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPersonController extends GetxController {
  // List to store the fetched data from Firebase
  RxList<Person> listPerson = <Person>[].obs;
  RxBool isLoading = false.obs;
  // Filtered list based on search criteria
  RxList<Person> filteredList = <Person>[].obs;
  Future<void> fetchDataFromFirebase() async {
    isLoading.value = true;
    QuerySnapshot queryDataSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    List<Person> profileList = [];
    queryDataSnapshot.docs.forEach((doc) {
      profileList.add(Person.fromDataSnapshot(doc));
    });
    listPerson.assignAll(profileList);
    filteredList.assignAll(profileList);
    isLoading.value = false;
  }

  // Function to filter the data based on search criteria

  void filterbyname({
    String? name,
  }) {
    filteredList.value = listPerson.where((person) {
      bool isMatched = true;
      if (name != null &&
          !person.name!.toLowerCase().contains(name.toLowerCase())) {
        isMatched = false;
      }

      return isMatched;
    }).toList();

    // Update the UI with the filtered list
    update();
  }

  Rx<int> selectedValue = Rx<int>(10);
  Rx<RangeValues> ageRange = Rx<RangeValues>(const RangeValues(15, 45));
  Rx<double> distanceValue = (-1.0).obs;
  Rx<double> heightValue = (-1.0).obs;
  Rx<double> weightValue = (-1.0).obs;
  Rx<String> genderValue = Rx<String>("");
  Rx<String> religionValue = Rx<String>("Select Religion");
  void filterData() {
    filteredList.value = listPerson.where((person) {
      print('person: ${person.name} ${person.age}');
      bool isMatched = true;

      if (ageRange.value.start > person.age! &&
          ageRange.value.end < person.age!) {
        print('ageRange: ${ageRange.value.start} ${ageRange.value.end}');
        isMatched = false;
      }

      if (genderValue.value != "" &&
          (person.gender ?? "male").toLowerCase() !=
              genderValue.value.toLowerCase()) {
        print('genderValue: ${genderValue.value}');
        isMatched = false;
      }
      if (religionValue.value != 'Select Religion' &&
          person.religion!.toLowerCase() != religionValue.value.toLowerCase()) {
        print('religionValue: ${religionValue.value} ${person.religion}');
        isMatched = false;
      }
      if (heightValue.value != (-1.0) &&
          double.parse(person.height!) >= heightValue.value) {
        print('heightValue: ${heightValue.value} ${person.height}');
        isMatched = false;
      }
      if (weightValue.value != (-1.0) &&
          double.parse(person.weight!) >= weightValue.value) {
        print('weightValue: ${weightValue.value} ${person.weight}');
        isMatched = false;
      }

      return isMatched;
    }).toList();

    update();
  }
}
