import 'package:flutter/material.dart';
import 'package:final_year_project_italea/Constant/color.dart';

class CircularTextField extends StatefulWidget {
  final String text;
  final bool isPasswordType;
  final TextEditingController controller;

  const CircularTextField({
    Key? key,
    required this.text,
    required this.isPasswordType,
    required this.controller,
  }) : super(key: key);

  @override
  _CircularTextFieldState createState() => _CircularTextFieldState();
}

class _CircularTextFieldState extends State<CircularTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPasswordType && !isPasswordVisible,
      enableSuggestions: !widget.isPasswordType || isPasswordVisible,
      autocorrect: !widget.isPasswordType || isPasswordVisible,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
      ),
      decoration: InputDecoration(
        prefixIcon: widget.isPasswordType
            ? const Icon(Icons.lock_outline, color: Colors.deepOrangeAccent,)
            : const Icon(Icons.person_outlined, color: Colors.deepOrangeAccent,),
        hintText: widget.text,
        labelText: widget.text,
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.9),
        ),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: hexStringToColor("90E0EF"), width: 3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: hexStringToColor("00849C"), width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        suffixIcon: widget.isPasswordType
            ? IconButton(
          icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        )
            : null,
      ),
      keyboardType: widget.isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}
