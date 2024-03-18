import 'package:dating_app/authenticationScreen/homescreen.dart';
import 'package:dating_app/authenticationScreen/registration.dart';
import 'package:dating_app/controller/authentication_controller.dart';
import 'package:dating_app/controller/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dating_app/widgets/custom_text.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var controllerAuth = AuthenticationController.authController;
  bool showProgressBar = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100),
            Image.asset('images/logo.png', width: 300),
            Text(
              "Welcome To DatingApp",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
            ElevatedButton(
              onPressed: () async {
                // Implement your login logic here
                if (emailController.text.trim().isNotEmpty &&
                    passwordController.text.trim().isNotEmpty) {
                  setState(() {
                    showProgressBar = true;
                  });
                  Helper().saveLoginStatus(true);
                  await controllerAuth.loginUser(emailController.text.trim(),
                      passwordController.text.trim());
                  setState(() {
                    showProgressBar = false;
                  });
                } else {
                  Get.snackbar(
                      "Email/password is Missing", "Please fill all field");
                }

                // For navigation, you can use Get package or Navigator
              },
              child: const Text(
                'Login',
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
                  "Don't have an account?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Implement your signup logic here
                    Get.to(RegistrationScreen());
                  },
                  child: Text(
                    "Sign Up",
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
    );
  }
}
