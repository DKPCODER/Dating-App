import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dating_app/controller/authentication_controller.dart';
import 'package:dating_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'homescreen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showProgressBar = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  String countryController = "Select Country";
  final TextEditingController profileHeadingController =
      TextEditingController();
  final TextEditingController lookingforpartnerController =
      TextEditingController();

  // Appearance
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController bodytypeController = TextEditingController();

  // LifeStyle
  final TextEditingController drinkController = TextEditingController();
  final TextEditingController smokeController = TextEditingController();
  final TextEditingController martialStatusController = TextEditingController();
  final TextEditingController haveChildrenController = TextEditingController();
  final TextEditingController noOfChildrenController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController employmentstatusController =
      TextEditingController();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController livingSituationController =
      TextEditingController();
  final TextEditingController willingToRelocateController =
      TextEditingController();
  final TextEditingController relationshipController = TextEditingController();
  String genderValue = "";
  // CulturalValues
  final TextEditingController nationalController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  String languageController = "Select Language";

  String religion = "Select Religion";
  final TextEditingController ethnicityController = TextEditingController();

  var authenticationController = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 3),
              const Text(
                "to get Started Now",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 246, 231, 68),
                ),
              ),
              SizedBox(height: 15),
              authenticationController.imageFile == null
                  ? const CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.black,
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('images/profile_avatar.jpg'),
                      ),
                    )
                  : Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: FileImage(
                              File(authenticationController.imageFile!.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      await authenticationController
                          .captureImageFromPhoneCamera();
                      setState(() {
                        authenticationController.imageFile;
                      });
                    },
                    icon: Icon(Icons.camera_alt),
                    color: Colors.grey,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () async {
                      await authenticationController.pickImageFileFromGallery();
                      setState(() {
                        authenticationController.imageFile;
                      });
                    },
                    icon: Icon(Icons.image_outlined),
                    color: Colors.grey,
                  ),
                ],
              ),

              SizedBox(height: 15),
              const Text(
                "Personal Info",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  editingController: nameController,
                  labelText: "Name",
                  icon: Icons.person,
                  isObscure: false,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  editingController: ageController,
                  labelText: "Age",
                  icon: Icons.calendar_today,
                  isObscure: false,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  editingController: emailController,
                  labelText: "Email",
                  icon: Icons.email,
                  isObscure: false,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  editingController: passwordController,
                  labelText: "Password",
                  icon: Icons.lock,
                  isObscure: true,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  editingController: phoneNoController,
                  labelText: "Phone Number",
                  icon: Icons.phone,
                  isObscure: false,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  editingController: cityController,
                  labelText: "City",
                  icon: Icons.location_city,
                  isObscure: false,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: countryController,
                    underline: Container(),
                    onChanged: (String? newValue) {
                      countryController = newValue!;
                      setState(() {});
                    },
                    items: <String>[
                      "Select Country",
                      "USA",
                      "Canada",
                      "UK",
                      "Australia",
                      "India",
                      "Pakistan",
                      "Bangladesh",
                      "Sri Lanka",
                      "Nepal",
                      "Bhutan",
                      "Maldives",
                      "Afghanistan",

                      // Add more countries as needed
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  editingController: profileHeadingController,
                  labelText: "Profile Heading",
                  icon: Icons.title,
                  isObscure: false,
                ),
              ),
              SizedBox(height: 15),
              // Add Appearance Fields
              const Text(
                "Appearance Info",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  editingController: heightController,
                  labelText: "Height",
                  icon: Icons.height,
                  isObscure: false,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  editingController: weightController,
                  labelText: "Weight",
                  icon: Icons.line_weight,
                  isObscure: false,
                ),
              ),

              SizedBox(height: 15),
              // Add LifeStyle Fields
              const Text(
                "LifeStyle Info",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  editingController: drinkController,
                  labelText: "Drink",
                  icon: Icons.local_bar,
                  isObscure: false,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  editingController: nationalController,
                  labelText: "Nationality",
                  icon: Icons.flag,
                  isObscure: false,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  editingController: educationController,
                  labelText: "Education",
                  icon: Icons.school,
                  isObscure: false,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: languageController,
                    underline: Container(),
                    onChanged: (String? newValue) {
                      languageController = newValue!;
                      setState(() {});
                    },
                    items: <String>[
                      "Select Language",
                      "English",
                      "Spanish",
                      "French",
                      "German",
                      "Hindi"
                      // Add more languages as needed
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: "male",
                        groupValue: genderValue,
                        onChanged: (value) {
                          genderValue = value!;
                          setState(() {});
                        },
                      ),
                      Text("Male"),
                      Radio(
                        value: "female",
                        groupValue: genderValue,
                        onChanged: (value) {
                          genderValue = value!;
                          setState(() {});
                        },
                      ),
                      Text("Female"),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1.0),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: religion,
                    underline: Container(),
                    onChanged: (String? newValue) {
                      religion = newValue!;
                      setState(() {});
                    },
                    items: <String>[
                      "Select Religion",
                      "Christianity",
                      "Islam",
                      "Hinduism",
                      "Buddhism",
                      "Judaism",
                      "Sikhism",
                      "Other"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),

              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  // Implement your login logic here
                  if (authenticationController.imageFile != null) {
                    // int phoneNumber =
                    //     int.tryParse(phoneNoController.text.trim()) ?? 0;
                    // int numberOfChildren =
                    //     int.tryParse(noOfChildrenController.text.trim()) ?? 0;

                    // // Parsing profession and relationship status to boolean
                    // bool profession =
                    //     professionController.text.trim().toLowerCase() ==
                    //         'true';
                    // bool relationshipStatus =
                    //     relationshipController.text.trim().toLowerCase() ==
                    //         'true';

                    if (emailController.text.trim().isNotEmpty &&
                        passwordController.text.trim().isNotEmpty &&
                        nameController.text.trim().isNotEmpty &&
                        ageController.text.trim().isNotEmpty &&
                        phoneNoController.text.trim().isNotEmpty &&
                        genderValue != "" &&
                        cityController.text.trim().isNotEmpty &&
                        countryController != "Select Country" &&
                        profileHeadingController.text.trim().isNotEmpty &&
                        heightController.text.trim().isNotEmpty &&
                        weightController.text.trim().isNotEmpty &&
                        drinkController.text.trim().isNotEmpty &&
                        nationalController.text.trim().isNotEmpty &&
                        educationController.text.trim().isNotEmpty &&
                        languageController != "Select Language" &&
                        religion.trim() != 'Select Religion') {
                      setState(() {
                        showProgressBar = true;
                      });

                      await authenticationController.createNewUserAccount(
                        gender: genderValue.toLowerCase(),
                        imageProfile:
                            File(authenticationController.imageFile!.path),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        name: nameController.text.trim(),
                        phoneNo: phoneNoController.text.trim(),
                        city: cityController.text.trim(),
                        age: int.parse(ageController.text.trim()),

                        country: countryController,
                        profileHeading: profileHeadingController.text.trim(),
                        lookingForPartner:
                            lookingforpartnerController.text.trim(),
                        height: heightController.text.trim(),
                        weight: weightController.text.trim(),
                        bodyType: bodytypeController.text.trim(),
                        drink: drinkController.text.trim(),
                        smoke: smokeController.text.trim(),
                        martialStatus: martialStatusController.text.trim(),
                        // haveChildren:haveChildrenController.text.trim(),
                        // noOfChildren:noOfChildrenController.text.trim(),
                        profession: professionController.text.trim(),
                        employmentStatus:
                            employmentstatusController.text.trim(),
                        income: incomeController.text.trim(),
                        livingSituation: livingSituationController.text.trim(),
                        //  willingToRelocate: willingToRelocateController.text.trim(),
                        relationship: relationshipController.text.trim(),
                        nationality: nationalController.text.trim(),
                        education: educationController.text.trim(),
                        language: languageController,
                        religion: religion,
                        ethnicity: ethnicityController.text.trim(),
                      );
                      setState(() {
                        showProgressBar = false;
                        authenticationController.imageFile == null;
                      });
                    } else {
                      Get.snackbar(
                        "A Field is Empty",
                        "Please fill out all fields.",
                      );
                    }
                  } else {
                    Get.snackbar(
                      "Image File Missing",
                      "Please pick an image from the gallery or capture it with the camera.",
                    );
                  }

                  // For navigation, you can use Get package or Navigator
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  minimumSize: MaterialStateProperty.all(
                    Size(110, 50), // Adjust the size as needed
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement your signup logic here
                      Get.back();
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              showProgressBar == true
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Container(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
