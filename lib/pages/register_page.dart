import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late double deviceWidth;
  late double deviceHeight;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  String? name, email, password;
  bool obscureText = true;
  File? _image;

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitle(),
                _buildProfileWidget(),
                _buildRegistrationForm(),
                _buildRegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() => Text(
    'Finstagram',
    style: TextStyle(
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.w600,
    ),
  );

  Widget _buildRegistrationForm() => Container(
    height: deviceHeight * 0.30,
    child: Form(
      key: _registerFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildNameField(),
          _buildEmailField(),
          _buildPasswordField(),
        ],
      ),
    ),
  );

  Widget _buildNameField() => TextFormField(
    decoration: const InputDecoration(
      labelText: "Name",
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    onSaved: (newValue) => name = newValue,
    validator:
        (value) =>
            (value == null || value.isEmpty) ? 'Please enter your name' : null,
  );

  Widget _buildEmailField() => TextFormField(
    keyboardType: TextInputType.emailAddress,
    decoration: const InputDecoration(
      labelText: "Email",
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    onSaved: (newValue) => email = newValue,
    validator:
        (value) =>
            (value == null || value.isEmpty) ? 'Please enter your email' : null,
  );

  Widget _buildPasswordField() => TextFormField(
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: "Password",
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: const OutlineInputBorder(),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      suffixIcon: IconButton(
        icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: () => setState(() => obscureText = !obscureText),
      ),
    ),
    onSaved: (value) => password = value,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }
      if (value.length < 6) {
        return 'Password must be at least 6 characters';
      }
      return null;
    },
  );

  Widget _buildRegisterButton() => MaterialButton(
    minWidth: deviceWidth * 0.70,
    height: deviceHeight * 0.06,
    color: Colors.redAccent,
    onPressed: registerUser,
    child: const Text(
      "Register",
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _buildProfileWidget() {
    final imageProvider =
        _image != null
            ? FileImage(_image!)
            : const NetworkImage(
              'https://images.pexels.com/photos/35537/child-children-girl-happy.jpg',
            );
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: deviceHeight * 0.13,
        width: deviceHeight * 0.13,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _image = File(result.files.first.path!);
      });
    }
  }

  void registerUser() {
    if (_registerFormKey.currentState!.validate() && _image != null) {
      _registerFormKey.currentState?.save();
      print('Name: $name');
      print('Email: $email');
      print('Password: $password');
      print("Image $_image");
    }
  }
}
