import 'dart:io';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/Models/person.dart';
import 'package:dating_app/authenticationScreen/homescreen.dart';
import 'package:dating_app/authenticationScreen/loginscreen.dart';
import 'package:dating_app/controller/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Models/person.dart' as personModel;

class AuthenticationController extends GetxController {
  static AuthenticationController authController = Get.find();
  late Rx<User?> firebaseCurrentUser;
  Rx<File> pickedFile = File('').obs;
  File? get profileImage => pickedFile.value;

  XFile? imageFile;
  pickImageFileFromGallery() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      Get.snackbar("Profile Image",
          "You have successfully picked an image from the gallery",
          snackPosition: SnackPosition.TOP);
    }
    pickedFile.value = File(imageFile!.path);
  }

  captureImageFromPhoneCamera() async {
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      Get.snackbar("Profile Image",
          "You have successfully captured your profile image from camera",
          snackPosition: SnackPosition.TOP);
    }
    pickedFile.value = (File(imageFile!.path));
  }

  static FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> GetImageUrl(File file) async {
    final ext = file.path.split('.').last;
    log('Extension: $ext');
    final ref = storage.ref().child(
        'profile_pictures/${FirebaseAuth.instance.currentUser!.email}.$ext');

    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    String image = await ref.getDownloadURL();
    return image;
  }

  createNewUserAccount({
    String? gender,
    String? email,
    String? password,
    File? imageProfile,
    String? name,
    int? age,
    String? phoneNo,
    String? city,
    String? country,
    String? profileHeading,
    String? lookingForPartner,
    String? height,
    String? weight,
    String? bodyType,
    String? drink,
    String? smoke,
    String? martialStatus,
    // bool? haveChildren,
    // int? noOfChildren,
    String? profession,
    String? employmentStatus,
    String? income,
    String? livingSituation,
    // bool? willingToRelocate,
    String? relationship,
    String? nationality,
    String? education,
    String? language,
    String? religion,
    String? ethnicity,
  }) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      String urlOfDownloadImage = await GetImageUrl(File(imageProfile!.path));
      print("Image URL: " + urlOfDownloadImage);
      print(urlOfDownloadImage);
      Person personInstance = Person(
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: email,
          password: password,
          name: name,
          age: age,
          phoneNo: phoneNo,
          city: city,
          country: country,
          profileHeading: profileHeading,
          lookingForPartner: lookingForPartner,
          imageProfile: urlOfDownloadImage,
          publishedDateTime: DateTime.now().millisecondsSinceEpoch,
          height: height,
          weight: weight,
          bodyType: bodyType,
          drink: drink,
          smoke: smoke,
          martialStatus: martialStatus,
          profession: profession,
          employmentStatus: employmentStatus,
          income: income,
          livingSituation: livingSituation,
          relationship: relationship,
          nationality: nationality,
          education: education,
          language: language,
          religion: religion,
          ethnicity: ethnicity,
          id: FirebaseAuth.instance.currentUser!.uid,
          likedBy: [],
          dislikedBy: [],
          gender: gender);

      print(personInstance.toJson());
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(personInstance.toJson());
      Get.snackbar("Account Created", "Congratulation");
      Helper().saveLoginStatus(true);
      Get.offAll(HomeScreen());
    } catch (errorMsg) {
      Get.snackbar(
          "Account Creation Unsuccessful", "Error occurence: $errorMsg");
    }
  }

  loginUser(String emailUser, String passwordUser) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailUser, password: passwordUser);
      Get.snackbar("Login successful", "You are loggin-in successfully.");

      Get.offAll(HomeScreen());
    } catch (errorMsg) {
      Get.snackbar("Login unsuccessful", "Error occured:$errorMsg");
    }
  }

  checkIfUserIsLoggedIn(User? currentUser) {
    if (currentUser == null) {
      Get.to(LoginPage());
    } else {
      Get.to(HomeScreen());
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    firebaseCurrentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseCurrentUser.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(firebaseCurrentUser, checkIfUserIsLoggedIn);
  }
}
