import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/Models/person.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  RxList<Person> usersProfileList = RxList<Person>();

  List<Person> get allUserProfileList => usersProfileList.value;
  RxBool isLoading = false.obs;
  Rx<Person> mydata = Person().obs;
  setMyData(Person person) {
    mydata.value = person;
    print(mydata.value);
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      QuerySnapshot queryDataSnapshot1 = await FirebaseFirestore.instance
          .collection("users")
          .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      setMyData(Person.fromDataSnapshot(queryDataSnapshot1.docs.first));
      QuerySnapshot queryDataSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      List<Person> profileList = [];
      queryDataSnapshot.docs.forEach((doc) {
        profileList.add(Person.fromDataSnapshot(doc));
      });

      print(queryDataSnapshot.docs);
      usersProfileList.assignAll(profileList);
    } catch (error) {
      print("Error fetching data: $error");
    }

    isLoading.value = false;
  }

  Future<void> addLikedPerson(String id) async {
    try {
      var personRef = FirebaseFirestore.instance.collection('users').doc(id);
      await personRef.update({
        'likedBy': FieldValue.arrayUnion([mydata.value.toJson()])
      });
      print("Liked person added successfully");
    } catch (error) {
      print("Error adding liked person: $error");
      throw error;
    }
  }

  Future<void> addDislikedPerson(String id) async {
    try {
      var personRef = FirebaseFirestore.instance.collection('users').doc(id);
      await personRef.update({
        'dislikedBy': FieldValue.arrayUnion([mydata.value.toJson()])
      });
      print("Disliked person added successfully");
    } catch (error) {
      print("Error adding disliked person: $error");
      throw error;
    }
  }
}
