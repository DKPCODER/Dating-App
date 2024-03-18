import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final TextEditingController editingController;
  final IconData icon;
  final String labelText;
  final bool isObscure;

  const CustomText({
    Key? key,
    required this.editingController,
    required this.icon,
    required this.labelText,
    required this.isObscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: editingController,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          fontSize: 20,
        ),
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        labelText: labelText,
      ),
      obscureText: isObscure,
    );
  }
}
